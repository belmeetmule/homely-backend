require 'rails_helper'
require 'json'

RSpec.describe 'POST /login', type: :request do
  let(:user) do
    User.create!(full_name: 'full name',
                 email: 'usertest@email.com',
                 password: 'passwordtest123')
  end

  let(:params) do
    {
      user: {
        full_name: user.full_name,
        email: user.email,
        password: user.password
      }
    }
  end

  describe 'POST /signup', type: :request do
    context 'when user is unauthenticated' do
      before do
        post '/signup', params: { user: { full_name: 'abebe ho', email: 'extest@gmail.com', password: 'my1234' } }
      end

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns a new user' do
        expect(response.body).to include('extest@gmail.com')
      end
    end

    context 'when user already exists' do
      before do
        post('/signup', params:)
        post '/signup', params:
      end

      it 'returns bad request status' do
        expect(response.status).to eq 422
      end

      it 'returns validation errors' do
        expect(response.body).to include("Sorry, user couldn't be created. Full name has already been taken and Email has already been taken")
      end
    end
  end

  describe 'POST /login' do
    context 'when params are correct' do
      before do
        post '/login', params: { user: { email: user.email, password: user.password } },
                       headers: { 'Accept' => 'application/json' }
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns JWT token in authorization header' do
        expect(response.headers['authorization']).to be_present
      end

      it 'returns valid JWT token' do
        token_from_request = response.headers['Authorization'].split.last

        decoded_token = JWT.decode(token_from_request, Rails.application.credentials.fetch(:secret_key_base), true)

        # NOTE: on decoded_token.first['sub']
        # The 'sub' claim is a standard claim that is used to identify the subject of the JWT token.
        # The value of the sub claim is typically a unique identifier for the user such as user_id.

        # comparing the user id from the decoded token to the user id from the database
        expect(decoded_token.first['sub']).to eq(user.id.to_s)
      end
    end

    context 'when login params are incorrect' do
      # simulate invalid login params
      before do
        post '/login', params: { user: { email: 'invalid@email.com', password: 'invalidpassword' } },
                       headers: { 'Accept' => 'application/json' }
      end

      it 'returns unathorized status' do
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE /logout', type: :request do
    let(:url) { '/logout' }
    before do
      # simulate valid session
      post '/login', params: { user: { email: user.email, password: user.password } },
                     headers: { 'Accept' => 'application/json' }
      # get token from response
      token_from_request = response.headers['Authorization']
      # send delete request with token
      delete url, headers: { 'Content-Type': 'application/json', 'Authorization' => token_from_request }
    end

    context 'when logged in user sends delete/logout/ request' do
      it 'returns 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'When inactive user/user with expired session/ sends delete/logout/ request' do
      before do
        # simulate valid session
        post '/login', params: { user: { email: user.email, password: user.password } },
                       headers: { 'Accept' => 'application/json' }
        # simulate expired/invalid/ session
        token_from_request = response.headers['Authorization'].split.last
        # send delete request with the invalid token
        delete url, headers: { 'Content-Type': 'application/json', 'Authorization' => token_from_request }
      end

      it 'returns 401' do
        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET /current_user', type: :request do
    let(:url) { '/current_user' }
    before do
      # simulate valid session
      post '/login', params: { user: { email: user.email, password: user.password } },
                     headers: { 'Accept' => 'application/json' }
      # get token from response
      token_from_request = response.headers['Authorization']
      # send get request with token
      get url, headers: { 'Content-Type': 'application/json', 'Authorization' => token_from_request }
    end

    context 'when logged in user sends get request' do
      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns current user' do
        expect(response.body).to include(user.email)
      end
    end

    context 'When inactive user/user with expired session/ sends get request' do
      before do
        # simulate invalid session by sending empty email and password
        post '/login', params: { user: { email: '', password: '' } }, headers: { 'Accept' => 'application/json' }
        # get token from response
        token_from_request = response.headers['Authorization']
        # send get request with token
        get url, headers: { 'Content-Type': 'application/json', 'Authorization' => token_from_request }
      end

      it 'returns 401' do
        expect(response.status).to eq(401)
      end
    end
  end
end
