module Bayesball
  module Persistence
    class Mongo
      include Enumerable

      attr_reader :db
      def initialize(uri, options={})
        collection_name = options.delete(:collection) || 'bayesball_categories'
        @db = build_db(uri, options)
        @collection = db.collection(collection_name)
      end

      def empty?
        @collection.count == 0
      end

      def [](key)
        doc = @collection.find_one(name: key)
        doc && doc['counts'] || {}
      end

      def []=(key, value)
        @collection.update({name: key}, {name: key, counts: value}, {upsert: true})
      end

      def each
        if block_given?
          @collection.find.each do |item|
            yield [item['name'], item['counts']]
          end
        else
          Enumerator.new(self, :each)
        end
      end

      private

      def build_db(uri, options={})
        parts = URI.parse(uri)
        raise "scheme must be mongodb, found #{parts.scheme}" unless parts.scheme == 'mongodb'
        db = ::Mongo::Connection.new(parts.host, parts.port, options).db(parts.path.gsub(/^\//, ''))
        db.authenticate(parts.user, parts.password) if parts.user && parts.password
        db
      end
    end
  end
end
