module FixerApi
    class CurrencyConversion
        def initialize(from:, to:, amount:)
            @from = from
            @to = to
            @amount = amount
        end
        
        def convert
            access_key = "3784348d5057a9b2975436903d61b263"

            response = Faraday.get("http://data.fixer.io/api/latest?access_key=#{access_key}&#{@from}")
            parsed_response_body = JSON.parse(response.body)
            rate = parsed_response_body["rates"][@to]

            (@amount * rate).round(2)
        end
    end
end