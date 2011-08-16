require 'rubygems'
require 'fakeweb'
require 'rspec'

require 'vertigo'

RSpec.configure do |c|
  c.mock_with :rspec
end

FakeWeb.allow_net_connect = false
