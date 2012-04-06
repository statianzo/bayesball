require "bayesball/version"

module Bayesball
end

%w{classifier}.each { |r| require "bayesball/#{r}" }
