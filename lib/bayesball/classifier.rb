module Bayesball
  class Classifier
    STOP_WORDS = IO.read(File.expand_path('../stopwords.txt',__FILE__)).split

    def initialize(persistence = {})
      @persistence = persistence
    end

    def train(category, payload)
      counts = @persistence[category] ||= {}

      word_counts(payload).each do |word, count|
        counts[word] = counts.fetch(word,0) + count
      end
      @persistence[category] = counts
    end

    def word_counts(payload)
      words = payload.downcase.gsub(/[^\w]|(\b\w{1,2}\b)/,' ').split.reject { |w| STOP_WORDS.include?(w) }
      words.reduce(Hash.new(0)) do |memo, word|
        memo[word] += 1
        memo
      end
    end

    def score(payload)
      @persistence.reduce(Hash.new(0)) do |memo, (category, counts)|
        total = counts.values.reduce(:+).to_f
        word_counts(payload).each do |word, count|
          s = counts.fetch(word, 0.0001)
          memo[category] += Math.log(s/total)
        end
        memo
      end
    end

    def classify(payload)
      s = score(payload)
      s.sort_by{|_,v| v}.map{|k,_| k}.reverse.first
    end

    def seed(content)
      content.each do |category, counts|
        @persistence[category] = counts
      end
    end
  end
end
