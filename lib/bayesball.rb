require "bayesball/version"

module Bayesball
end

%w{classifier persistence}.each { |r| require "bayesball/#{r}" }
