module Bayesball
  module Persistence
    autoload :Mongo, 'bayesball/persistence/mongo'
    autoload :Sequel, 'bayesball/persistence/sequel'
  end
end
