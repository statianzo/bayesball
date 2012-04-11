require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
    puts ENV['TERM']
    t.libs = ['spec', 'lib']
    t.pattern = 'spec/**/*_spec.rb'
end
