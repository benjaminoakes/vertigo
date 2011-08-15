require 'soap/wsdlDriver'

# = API Versioning
# 
# As of 2011.08.15, VerticalResponse changes and remove API calls, but still call it API "v1.0" each time.  These mandatory API changes could break your code (although we have never experienced that personally).
# 
# Inquiring about their versioning policy got this response:
# 
#     For a variety of internal reasons, this is still considered the 1.0 release of our API. We're currently exploring adding real versioning to our API to avoid these kinds of issues going forward.
# 
# Because of this, Vertigo::Client regenerates the RPC driver when instantiated as the generated code for VRAPI.wsdl becomes stale over time.  Generating the driver incurs a startup cost, but it's minimal.
class Vertigo::Client
  WSDL = 'https://api.verticalresponse.com/partner-wsdl/1.0/VRAPI.wsdl'  
end
