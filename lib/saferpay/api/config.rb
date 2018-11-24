module Saferpay
  module Api
    cattr_accessor :version
    cattr_accessor :url
    cattr_accessor :customer_id
    cattr_accessor :terminal_id
    cattr_accessor :auth_token

    def self.configure
      yield self
    end
  end
end

require 'saferpay/api/client'
