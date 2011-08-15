require 'spec_helper'

describe Vertigo::Client do
  before :each do
    @username = 'you@yourcompany.com'
    @password = 'secret'
    @api = mock('API', :login => nil)
    @factory = mock('WSDLDriverFactory', :create_rpc_driver => @api)
  end

  it 'should create a RPC driver with the default WSDL' do
    SOAP::WSDLDriverFactory.should_receive(:new).with(Vertigo::Client::WSDL_URL).and_return(@factory)
    Vertigo::Client.new(@username, @password)
  end

  it 'should create a RPC driver with the specified WSDL' do
    url = 'https://api.verticalresponse.com/partner-wsdl/1.1/VRAPI.wsdl'  
    SOAP::WSDLDriverFactory.should_receive(:new).with(url).and_return(@factory)
    Vertigo::Client.new(@username, @password, :wsdl_url => url)
  end

  context 'with default WSDL' do
    before :each do
      SOAP::WSDLDriverFactory.stub!(:new).and_return(@factory)
    end

    it 'should log in with the given credentials' do
      @api.should_receive(:login, {
        'username' => @username,
        'password' => @username,
        'session_duration_minutes' => Vertigo::Client::DURATION_MINUTES
      })

      Vertigo::Client.new(@username, @password)
    end
  end
end
