require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /users' do
    before :each do
      auth = {
        provider: 'Github',
        uid: '12345',
        info: {
          email: 'email@domain.com'
        }
      }
      post '/api/v1/users', auth: auth
    end

    it { have_http_status(200) }
    it { change(User, :count).by(1) }

    it 'Should responds with the user found or created' do
      json = JSON.parse(response.body)
      puts json.to_s
      expect(json['email']).to eq('email@domain.com')
    end
  end
end
