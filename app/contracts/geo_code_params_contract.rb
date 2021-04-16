# frozen_string_literal: true

class GeoCodeParamsContract < Dry::Validation::Contract
  params do
    required(:city).filled(:string)
  end
end
