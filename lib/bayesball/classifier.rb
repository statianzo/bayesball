module Bayesball
  class Classifier
    STOP_WORDS = IO.read(File.expand_path('../stopwords.txt',__FILE__)).split

    def initialize
      @categories = {}
    end

    def categories
      @categories.keys
    end

    def train(category, payload)
      counts = (@categories[category] ||= Hash.new(0))

      word_counts(payload).each do |word, count|
        counts[word] += count
      end
    end

    def word_counts(payload)
      words = payload.downcase.gsub(/[^\w]|(\b\w{1,2}\b)/,' ').split.reject { |w| STOP_WORDS.include?(w) }
      words.reduce(Hash.new(0)) do |memo, word|
        memo[word] += 1
        memo
      end
    end

    def score(payload)
      @categories.reduce(Hash.new(0)) do |memo, (category, counts)|
        total = counts.values.reduce(:+).to_f
        word_counts(payload).each do |word, count|
          s = counts[word]
          s = 0.0001 if s <= 0
          memo[category] += Math.log(s/total)
        end
        memo
      end
    end

    def classify(payload)
      s = score(payload)
      s.sort_by{|k,v| v}.reverse[0][0]
    end
  end
end
