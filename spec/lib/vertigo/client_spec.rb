require 'spec_helper'

describe Vertigo::Client do
  before :each do
    @username = 'you@yourcompany.com'
    @password = 'secret'
    @api = mock('API', :login => 'mock session ID')
    @api.stub!(:unlaunchEmailCampaign)
    @api.stub!(:enumerateEmailCampaigns)
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

    it 'should log in with the given credentials and session duration' do
      @api.should_receive(:login, {
        'username' => @username,
        'password' => @username,
        'session_duration_minutes' => 5
      })

      Vertigo::Client.new(@username, @password, :duration_minutes => 5)
    end
  end

  context 'with client' do
    before :each do
      SOAP::WSDLDriverFactory.stub!(:new).and_return(@factory)

      @client = Vertigo::Client.new(@username, @password)
      # White box test
      @session_id = @client.instance_eval { @session_id }
    end

    it 'should allow Rubyish method calls' do
      @api.should_receive(:unlaunchEmailCampaign).with('session_id' => @session_id, 'campaign_id' => 1)
      @client.unlaunch_email_campaign(:campaign_id => 1)
    end

    it 'should allow Rubyish method calls with no arguments' do
      @api.should_receive(:enumerateEmailCampaigns).with('session_id' => @session_id)
      @client.enumerate_email_campaigns
    end

    it 'should still allow camelcase method calls' do
      @api.should_receive(:unlaunchEmailCampaign).with('session_id' => @session_id, 'campaign_id' => 1)
      @client.unlaunchEmailCampaign(:campaign_id => 1)
    end

    it 'should raise an error if given two arguments' do
      lambda { @client.unlaunch_email_campaign(2, :campaign_id => 1) }.should raise_error(ArgumentError)
    end

    it 'should raise an error if called with an undefined VerticalResponse API call' do
      lambda { @client.some_random_method(:campaign_id => 1) }.should raise_error(NoMethodError)
    end

    it 'should raise an error if given an unsupported argument' do
      lambda { @client.unlaunch_email_campaign(2) }.should raise_error(ArgumentError)
    end

    it 'should' do
      @api.should_receive(:createEmailCampaign).with(
        'session_id' => @session_id,
        'email_campaign' => {
          'name' => 'Campaign Name',
          'type' => 'freeform',
          'from_label' => 'from@example.com',
          'support_email' => 'support@example.com',
          'send_friend' => false,
          'contents' => [
            { 'type' => 'freeform_html', 'copy' => 'body' },
            { 'type' => 'freeform_text', 'copy' => 'body' },
            { 'type' => 'subject', 'copy' => 'subject' },
          ]
        }
      )

      @client.create_email_campaign(:email_campaign => {
        :name => 'Campaign Name',
        :type => 'freeform',
        :from_label => 'from@example.com',
        :support_email => 'support@example.com',
        :send_friend => false,
        :contents => [
          { :type => 'freeform_html', :copy => 'body' },
          { :type => 'freeform_text', :copy => 'body' },
          { :type => 'subject', :copy => 'subject' },
        ]
      })
    end
  end
end
