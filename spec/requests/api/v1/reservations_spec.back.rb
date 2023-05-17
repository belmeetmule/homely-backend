require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do

  path '/api/v1/users/{user_id}/reservations' do
    get 'Get user house reservations' do
    tags 'Visit reservation'
    produces 'application/json'
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    response '200' do
      before do
        @user = User.create(full_name: 'Mulugeta', email: 'mulu@homely.com', password: 'password')
        @house = House.create(name: 'White house villa', city: 'Addis Ababa', appartment_fee: 2000, description: 'abcde abce', image: 'https://www.house-images.png')
        @reservation = Reservation.create(user_id: @user.id, house_id: @house.id, reservation_date: Time.now)
        sign_in @user
      end

      let(:user_id) { @user.id }

      schema type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    reservation_date: { type: :date },
                  
                    house: { type: :object,
                            properties: {
                              id: { type: :integer },
                              name: { type: :string },
                              image: { type: :string },
                              city: { type: :string },
                              apartment_fee: { type: :decimal },
                              description: { type: :string }
                            },
                            required: %w[id name image city apartment_fee description] }
                  },
                  required: %w[id reservation_date house]
                }
          run_test!
        end

        response '401', 'You must Login or Register. Car Reservation not found' do
          let(:user_id) { 'invalid' }
          run_test!
        end
      end
  end
end
