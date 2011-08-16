require 'soap/wsdlDriver'

# Simple wrapper around the VerticalResponse SOAP API.
#
# = API Versioning
#
# As of 2011.08.15, VerticalResponse changes and remove API calls, but still call it API "v1.0" each time.  These mandatory API changes could break your code (although we have never experienced that personally).
#
# Inquiring about their versioning policy got this response:  "For a variety of internal reasons, this is still considered the 1.0 release of our API. We're currently exploring adding real versioning to our API to avoid these kinds of issues going forward."
#
# Because of this, Vertigo::Client regenerates the RPC driver when instantiated as the generated code for VRAPI.wsdl becomes stale over time.  Generating the driver incurs a startup cost, but it's minimal.
#
# @author Benjamin Oakes <hello@benjaminoakes.com>, @benjaminoakes
class Vertigo::Client
  DURATION_MINUTES = 4
  WSDL_URL = 'https://api.verticalresponse.com/partner-wsdl/1.0/VRAPI.wsdl'  

  # @param [String] username Account username
  # @param [String] password Account password
  # @param [Hash] opts Session options
  # @option opts [Fixnum] :duration_minutes Duration of session in minutes
  # @option opts [String] :wsdl_url Alternative WSDL URL
  #
  # @raise [SOAP::FaultError] when an API call fails
  #
  # @example Connect using session defaults
  #     client = Vertigo::Client.new('you@yourcompany.com', 'your password')
  #
  # @example Connect using the specified session options
  #     client = Vertigo::Client.new('you@yourcompany.com', 'your password', :duration_minutes => 5)
  def initialize(username, password, opts = {})
    session_duration_minutes = opts[:duration_minutes] || DURATION_MINUTES
    wsdl_url = opts[:wsdl_url] || WSDL_URL

    @api = SOAP::WSDLDriverFactory.new(wsdl_url).create_rpc_driver
    @session_id = @api.login(
      'username' => username.to_s,
      'password' => password.to_s,
      'session_duration_minutes' => session_duration_minutes
    )
  end

  # This modification lets us write API calls in a more "Rubyish" manner.
  #
  # @note camelCase method names are still supported.
  #
  # @raise [ArgumentError] when too many arguments or unsupported arguments
  # @raise [NoMethodError] when the API call is not defined
  #
  # @example Unlaunching an email campaign
  #     client.unlaunch_email_campaign(:campaign_id => 1)
  #     # Without Vertigo::Client, it would be:
  #     vrapi.unlaunchEmailCampaign('session_id' => session_id, 'campaign_id' => 1)
  def method_missing(name, *args, &block)
    options = args[0]
    vr_name = camelize_meth(name).intern

    if args.length > 1
      raise ArgumentError, 'Unexpected number of arguments (not 0 or 1)'
    elsif options && !options.respond_to?(:keys)
      raise ArgumentError, "options does not respond to :keys (options.class: #{options.class}, options: #{options.inspect})"
    end

    if @api.respond_to?(vr_name)
      vr_args = options ? stringify_keys(options) : {}
      @api.send(vr_name, {'session_id' => @session_id}.merge(vr_args))
    else
      raise NoMethodError, "Undefined VerticalResponse API call: #{vr_name.inspect}"
    end
  end

private

  # Camelize a method name
  # 
  # @param [String, Symbol] name
  def camelize_meth(name)
    name.to_s.gsub(/_([a-z])/) { $1.upcase }
  end

  # Recursively stringify keys of Hashes and members of Arrays
  #
  # @param [Hash, Array, Object] original
  def stringify_keys(original)
    if original.respond_to?(:keys)
      Hash[original.map { |key, val| [key.to_s, stringify_keys(val)] }]
    elsif original.kind_of?(Array)
      original.map { |val| stringify_keys(val) }
    else
      original
    end
  end
end
