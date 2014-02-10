# Bayesball

Bayesball is a naive Bayes classifier with support for in memory and mongo
persistence.

## Installation

Add this line to your application's Gemfile:

    gem 'bayesball'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bayesball

## Usage

```ruby
classifier = Bayesball::Classifier.new

classifier.train 'basketball', 'dunk the ball'

classifier.classify 'Slam Dunk!' #=> "basketball"

classifier.train 'football', 'kicked the ball through the up-rights'
classifier.train 'soccer', 'kicked the ball into the net'
classifier.train 'hockey', 'hit the puck into the net'

# 2nd parameter is top_how_many classifications to return
classifier.classify 'Jimmy kicked the ball', 2 #=> ["soccer", "football"]

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
