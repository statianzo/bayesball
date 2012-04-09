require 'bundler/setup'
MONGO_URI = ENV['MONGO_URI'] || 'mongodb://localhost/test'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'bayesball'
require 'minitest/pride'
require 'minitest/autorun'

Bundler.require :development
