# frozen_string_literal: true

module AdsService
  module Api
    def update_coordinates(id, coordinates)
      coordinates = { lat: coordinates[0], lon: coordinates[1] }
      response = connection.patch("v1/#{id}") do |request|
        request.params = { coordinates: coordinates }
        request.headers['X-Request-Id'] = Thread.current[:request_id]
      end

      Application.logger.info(
        'requested coordinates updating',
        id: id,
        coordinates: coordinates,
        status: response.status
      )
    end
  end
end
