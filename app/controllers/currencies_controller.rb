require_relative '../../db/dictionary'

class CurrenciesController < ApplicationController
    def index
        @countries_for_select = countries_for_select
        @currencies_for_select = currencies_for_select
        @currencies_for_conversion = currencies_for_conversion
        country_to_currencies_map = Dictionary.country_to_currencies
        currency_to_countries_map = Dictionary.currency_to_countries
        
        if params["amount"].present? && params["convert_from"].present? && params["convert_to"].present?
            i = FixerApi::CurrencyConversion.new(from: params["convert_from"], to: params["convert_to"], amount: params["amount"].to_i)
            @rate = i.convert
        elsif params["country"].present?
            country = params["country"]
            @currencies = country_to_currencies_map[country]
        elsif params["currency"].present?
            currency = params["currency"]
            @countries = currency_to_countries_map[currency]
        end
    end

    private

    def currencies_for_conversion
        Dictionary.currencies.map { |currency| [currency, currency] }
    end

    def countries_for_select
        Dictionary.country_to_currencies.map { |country, currencies| [country, country] }
    end

    def currencies_for_select
        Dictionary.currency_to_countries.map { |currency, countries| [currency, currency] }
    end
end