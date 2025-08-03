# frozen_string_literal: true

module Api
  class YandexGeocoder
    include HTTParty
    base_uri ENV.fetch('YA_GEO_BASE_URL')

    def self.call(name)
      new(name).location
    end

    def self.cities_and_towns(name)
      new(name, %w[locality province]).location
    end

    def initialize(name, kind = nil)
      @name = name
      @kind = %w[locality province]
      @apikey = ENV.fetch('YA_GEO_KEY')
      @kind = kind
    end

    def location
      response = self.class.get('/', query: query_params)
      unless response.success?
        Rails.logger.error response.body
        return { errors: [JSON.parse(response.body, symbolize_names: true)] }
      end

      parse_location_response(response)
    rescue HTTParty::Error => e
      error = { error: e.message, message: 'Ошибка поиска географического местоположения в Яндексе Геокодере.' }
      Rails.logger.error error
      { errors: [error] }
    end

    private

    attr_reader :name, :kind, :apikey

    def query_params
      { apikey:,
        geocode: name,
        lang: 'ru',
        format: 'json' }
    end

    def parse_location_response(response)
      features = response.dig('response', 'GeoObjectCollection', 'featureMember') || []

      out = features.map do |geo|
        metadata = geo.dig('GeoObject', 'metaDataProperty', 'GeocoderMetaData')
        address = metadata['Address']
        point = geo.dig('GeoObject', 'Point', 'pos')

        {
          name: address['formatted'],
          kind: metadata['kind'],
          point: point
        }
      end
      { result: (kind.present? ? kind_filter(out) : out) }
    end

    def kind_filter(output)
      output.select { |obj| obj[:kind].in?(kind) }
    end
  end
end
