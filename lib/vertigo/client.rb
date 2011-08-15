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
# @author Benjamin Oakes <hello@benjaminoakes.com>
class Vertigo::Client
  WSDL = 'https://api.verticalresponse.com/partner-wsdl/1.0/VRAPI.wsdl'  

  # @param [String] username Account username
  # @param [String] password Account password
  # @param [Hash] opts Session options
  # @option opts [Fixnum] :duration_minutes
  #
  # @raise [SOAP::FaultError] when an API call fails
  #
  # @example Connect using session defaults
  #     client = Vertigo::Client.new('you@yourcompany.com', 'your password')
  #
  # @example Connect using the specified session options
  #     client = Vertigo::Client.new('you@yourcompany.com', 'your password', :duration_minutes => 5)
  def initialize(username, password, opts = {})
    # session_duration_minutes = opts[:duration_minutes] || 4

    # @vr_api = SOAP::WSDLDriverFactory.new(WSDL).create_rpc_driver
    # @session_id = @vr_api.login(
    #   'username' => username,
    #   'password' => password,
    #   'session_duration_minutes' => session_duration_minutes
    # )
  end
end
