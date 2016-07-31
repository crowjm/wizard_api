require 'rails_helper'
# See app/controllers/authentication_controller.rb
RSpec.describe AuthorizeApiRequest do
  describe 'Authentication' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'valid credentials are provided' do
      it 'returns an authenticated user' do
        post '/authenticate',
             'email' => user.email,
             'password' => user.password,
             'Content-Type' => 'application/json'

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        # check to make sure the right amount of messages are returned
        expect(json['auth_token']).to_not be_nil
      end
    end

    context 'invalid credentials provided' do
      it 'returns an authenticated user' do
        post '/authenticate',
             'email' => user.email,
             'password' => 'wrong password',
             'Content-Type' => 'application/json'

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to_not be_success
        # check to make sure the right amount of messages are returned
        expect(json['error']).to_not be_nil
      end
    end
  end
end
