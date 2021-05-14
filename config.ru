# frozen_string_literal: true

require_relative 'config/environment'

run Rack::URLMap.new(
  '/v1/geocode' => GeoCodeRoutes
)
