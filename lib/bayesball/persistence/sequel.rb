module Bayesball
  module Persistence
    class Sequel
      include Enumerable

      attr_reader :dataset
      def initialize(dataset)
        @dataset = dataset
      end

      def empty?
        @collection.count == 0
      end

      def [](key)
        dataset.where(bucket: key).to_hash(:word, :count)
      end

      def []=(key, value)
        dataset.where(bucket: key).delete
        value.each do |word, count|
          dataset.insert word: word, count: count, bucket: key
        end
      end

      def each
        if block_given?
          dataset.to_a.group_by{|i| i[:bucket] }.each do |bucket, group|
            counts = Hash[group.map{|g| [g[:word], g[:count]]}]
            yield [bucket, counts]
          end
        else
          self.to_enum
        end
      end
    end
  end
end
