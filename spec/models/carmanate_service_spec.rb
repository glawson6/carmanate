require 'rails_helper'

describe CarmanateService do

  let (:api_key) {"uvgp3r9dfpve37bchqu4vp4g"}
  let(:user) { FactoryGirl.create(:user) }
  let(:car_profile) { FactoryGirl.create(:car_profile, user: user) }
  let (:model_year_id_query_static) { "https://api.edmunds.com/api/vehicle/v2/honda/accord/2009?view=full&fmt=json&api_key=uvgp3r9dfpve37bchqu4vp4g" }
  let (:query_hash) {{car_profile: car_profile, user: user, api_key: api_key}}
  let (:model_year_id_query) {EdmundsApi.create_model_year_id_query(query_hash)}
  subject { model_year_id_query }
  describe 'create_model_year_id_query' do

      context 'not present' do
        it 'the same query string' do
          expect(model_year_id_query).to eq(model_year_id_query_static)
        end
      end
    end

end
