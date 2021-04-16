# frozen_string_literal: true

RSpec.describe GeoCodeRoutes, type: :routes do
  subject { described_class }

  describe 'GET /' do
    context 'existing city' do
      let(:lat) { 45.05 }
      let(:lon) { 90.05 }

      before do
        allow(Geocoder).to receive(:geocode)
          .with('City 17')
          .and_return([lat, lon])
      end

      it 'returns coordinates' do
        get '/', city: 'City 17'

        expect(last_response.status).to eq(200)
        expect(response_body).to eq('lat' => lat, 'lon' => lon)
      end
    end

    context 'missing city' do
      before do
        allow(Geocoder).to receive(:geocode)
          .with('City 17')
          .and_return(nil)
      end

      it 'does not return coordinates' do
        get '/', city: 'City 17'

        expect(last_response.status).to eq(404)
        expect(response_body).to eq({ 'errors' => [{ 'detail' => 'Запрашиваемый город не найден' }] })
      end
    end

    context 'missing parameters' do
      it 'returns an error' do
        get '/'

        expect(last_response.status).to eq(422)
        expect(response_body).to eq({ 'errors' => [{ 'detail' => 'В запросе отсутствуют необходимые параметры' }] })
      end
    end
  end
end
