# frozen_string_literal: true

class GeoCodeRoutes < Application
  get '/' do
    geocode_params = validate_with!(GeoCodeParamsContract)

    coordinates = Geocoder.geocode(geocode_params['city'])

    if coordinates.blank?
      status 404
      error_response I18n.t(:not_found, scope: 'api.errors')
    else
      status :ok
      json lat: coordinates[0], lon: coordinates[1]
    end
  end
end
