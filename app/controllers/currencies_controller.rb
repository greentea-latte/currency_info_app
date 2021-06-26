class CurrenciesController < ApplicationController
    def index
        if params["amount"].present? && params["currency_to_convert"].present?
            currency = params["currency_to_convert_to"].to_sym
            amount = params["amount"].to_i
            @rate = rates_for_one_euro[currency].to_i * amount
        elsif params["country"].present?
            country = params["country"].to_sym
            @currencies = currencies[country]
        elsif params["currency"].present?
            currency = params["currency"].to_sym
            @countries = countries[currency]
        end
    end

    private

    def rates_for_one_euro
        {
            "Peso": 57
        }
    end

    def currencies
        {
            "France": ["Euro"],
            "Mexico": ["Peso"]
        }
    end

    def countries
        {
            "Euro": ["France", "Spain", "Germany"],
            "Peso": ["Mexico"]

        }
    end
end