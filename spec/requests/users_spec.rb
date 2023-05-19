require 'swagger_helper'

RSpec.describe 'users', type: :request do
  path '/signup' do
    post 'Sign up' do
      tags 'Register new user'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object,
                  properties: {
                    full_name: { type: :string },
                    email: { type: :string },
                    password: { type: :string }
                  } }
        },
        required: %w[full_name email password]
      }

      response '200', 'Signed up sucessfully.' do
        let(:user) { { user: { full_name: 'Mulugeta B', email: 'mulub@gmail.com', password: 'password' } } }
        run_test!
      end

      response '422', "Sorry, user couldn't be created." do
        let(:user) { 'invalid params' }
        run_test!
      end
    end
  end

  path '/login' do
    post 'Sign in User' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'User logged in successfully' do
        before do
          User.create(full_name: 'Martha K', email: 'marty@homely.com', password: 'password')
        end
        let(:user) { { user: { email: 'marty@homely.com', password: 'password' } } }
        run_test!
      end

      response '401', 'Logged in failure' do
        let(:user) { 'invalid' }
        run_test!
      end
    end
  end

  path '/logout' do
    delete 'Sign out User' do
      tags 'Logout'
      consumes 'application/json'
      parameter name: :Authorization, in: :header, type: :string,
                description: 'Authorization JWT Token (Check Response Headers in login or register)'
      response '200', 'Logged out successfull' do
        before do
          @user = User.create(full_name: 'Martha M', email: 'martha@homely.com', password: 'password')
          def encode(payload, exp = 30.minutes.from_now)
            payload[:exp] = exp.to_i
            "Bearer #{JWT.encode(payload, Rails.application.credentials.fetch(:secret_key_base))}"
          end
          @token = encode({ sub: @user.id, jti: @user.jti, scp: 'user' })
        end

        let(:Authorization) { @token }
        run_test!
      end

      response '401', 'Authorization token is invalid' do
        let(:Authorization) { '' }
        run_test!
      end
    end
  end
end
