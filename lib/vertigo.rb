require 'rubygems'
require 'soap/soap' # For objects like SOAP::FaultError

module Vertigo
  autoload :Client, 'vertigo/client'
  autoload :VERSION, 'vertigo/version'
end
