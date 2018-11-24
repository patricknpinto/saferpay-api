module Saferpay
  module Api
    class Client
      def initialize(request_id)
        @connection = Faraday.new(url: "#{Saferpay::Api.url}/api/")
        @request_id = request_id
      end

      def initialize_payment(params)
        make_request('Payment/v1/PaymentPage/Initialize', initialize_body(params))
      end

      def assert_payment(params)
        make_request('Payment/v1/PaymentPage/Assert', assert_body(params))
      end

      def capture_payment(params)
        make_request('Payment/v1/Transaction/Capture', capture_body(params))
      end

      private

      def make_request(url, body)
        response = @connection.post do |req|
          req.url url
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/json'
          req.headers['Authorization'] = "Basic #{Saferpay::Api.auth_token}"
          req.body = body.to_json
        end

        JSON.parse(response.body)
      end

      def initialize_body(params)
        {
          RequestHeader: request_header_body(@request_id),
          TerminalId: Saferpay::Api.terminal_id,
          Payment: payment_body(params[:total_price], params[:code]),
          ReturnUrls: return_urls_body(params[:success_url], params[:fail_url])
        }
      end

      def assert_body(params)
        {
          RequestHeader: request_header_body(@request_id),
          Token: params[:token]
        }
      end

      def capture_body(params)
        {
          RequestHeader: request_header_body(@request_id),
          TransactionReference: transaction_reference_body(params[:transaction_id])
        }
      end

      def request_header_body(request_id)
        {
          SpecVersion: Saferpay::Api.version,
          CustomerId: Saferpay::Api.customer_id,
          RequestId: request_id,
          RetryIndicator: 0
        }
      end

      def payment_body(total_price, code)
        {
          Amount: {
            Value: total_price,
            CurrencyCode: 'eur'
          },
          OrderId: code,
          Description: "Order #{code}"
        }
      end

      def return_urls_body(success, fail)
        {
          Success: success,
          Fail: fail
        }
      end

      def transaction_reference_body(transaction_id)
        {
          TransactionId: transaction_id
        }
      end
    end
  end
end
