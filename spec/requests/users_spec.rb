require 'swagger_helper'

RSpec.describe 'users', type: :request do

    path '/signup' do
        post 'Sign up' do
            tags 'Signup'
            consumes 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    user: { type: :object,
                    properties:{
                        full_name: { type: :string },
                        email: { type: :string },
                        password: { type: :string }
                }}},
                required: %w[full_name email password]
            }

            response '200', 'Signed up sucessfully.' do
                before do
                    let(:user) {{user: {full_name: 'Mulugeta M', email: 'mulu@gmail.com', password: 'password'}}}
                end
                run_test!
            end

            response '422', "Sorry, user couldn't be created." do
                let(:usre) {'invalid params'}
                run_test!
            end
        end
    end

    path '/login' do
        post 'Authenticate user' do
            tags 'Login'
            consumes 'applicaiton/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                    user: { type: :object,
                    properties: {
                  email: { type: :string },
                  password: { type: :string }
                }}},
                required: %w[email password]
              }

            response '200', 'Logged in sucessfully.' do
                before do
                    User.create(full_name: 'Mulugeta M', email: 'mulu@gmail.com', password: 'password')
                end

                let(:user) {{user: {email: 'mulu@gmail.com', password: 'password'}}}
                run_test!
            end

            response '401', 'Couldn\'t find an active session.' do
                let(:user) {'invalid credentails'}
                run_test!
            end
        end
    end

    path '/logout' do
        delete 'Logout' do
            tags 'Logout'
            consumes 'applicaiton/json'
            parameter name: :Authorization, in: :header, type: :string,
            description: 'JWT Token returned in Response Headers for login or register requests'
            
            response '200', 'logged out successfully' do
                before do  
                    user = User.create(full_name: 'Mulugeta', email: 'mulu@homely.com', password: 'password')
                      # simulate valid session
                    post '/login', params: { user: { email: user.email, password: user.password } },
                    headers: { 'Accept' => 'application/json' }
                    # get token from response
                    token = response.headers['Authorization']
                end
                let(:Authorization) { token }
                run_test!
            end

            response '401', 'Couldn\'t find an active session.' do
                let(:Authorization) { '' }
                run_test!
            end
        end
    end
end

