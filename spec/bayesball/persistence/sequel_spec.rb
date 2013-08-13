require 'spec_helper'

module Bayesball
  module Persistence
    describe Sequel do
      let(:dataset) { SEQUEL_DB[:bayesball_buckets] }
      let(:persistence) { Sequel.new(dataset) }

      it 'should return counts' do
        persistence['truck'].wont_be_nil
      end

      it 'should set counts' do
        persistence['car'] = {'x' => 3, 'y' => 2}
        persistence['car'].must_equal 'x' => 3, 'y' => 2
      end

      it 'should reduce' do
        persistence['duck'] = {'x' => 8, 'y' => 5}
        persistence['cat'] = {'x' => 7, 'y' => 1}
        persistence['dog'] = {'x' => 2, 'y' => 2}

        result = persistence.reduce({}) do |memo, (category, counts)|
          total = counts.values.reduce(:+).to_f
          memo[category] = total
          memo
        end
        result['duck'].must_equal 13
        result['cat'].must_equal 8
        result['dog'].must_equal 4
      end

      it 'should return enumerator from each' do
         persistence.each.class.must_equal Enumerator
      end
    end
  end
end
