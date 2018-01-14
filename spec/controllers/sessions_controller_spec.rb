require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe '#create' do
        it 'returns 401 for unregistered users' do
            user = build(:person)

            post :create, params: {email: user.email, password: user.password}
            
            expect(response.status).to eq(401)
        end

        it 'returns a token for registered users' do
            user = create(:person)

            post :create, params: {email: user.email, password: user.password}

            expect(response.body).to include("token")
        end

        it 'returns the person without password' do
            user = create(:person)
            hash = user.attributes
            hash.delete("password_digest")
            hash.delete("last_activity")

            post :create, params: {email: user.email, password: user.password}

            json_resp = JSON.parse(response.body)
            expect(json_resp["person"]).to include(*hash.keys)
            expect(json_resp["person"]).not_to include("password")
        end
    end
end
