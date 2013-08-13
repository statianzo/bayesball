require 'bundler/setup'
MONGO_URI = ENV['MONGO_URI'] || 'mongodb://localhost/test'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'bayesball'
require 'minitest/pride'
require 'minitest/autorun'

Bundler.require :development

SEQUEL_DB = Sequel.connect 'sqlite:///'

SEQUEL_DB.create_table :bayesball_buckets do
  column :bucket, String, null: false
  column :word, String, null: false
  column :count, Integer, null: false

  index :bucket
  index [:bucket, :word], unique: true
end
