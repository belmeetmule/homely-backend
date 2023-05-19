require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/users/{user_id}/reservations' do
    get 'Get user house reservations' do
      tags 'List reservations'
      produces 'application/json'
      # You'll want to customize the parameter types...
      parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

      response '200', 'succesfful' do
        before do
          @user = User.create(full_name: 'Mulugeta', email: 'mulu@homely.com', password: 'password')
          @house = House.create(name: 'White house villa', city: 'Addis Ababa', appartment_fee: 2000, description: 'abcde abce', image: 'https://www.house-images.png')
          @reservation = Reservation.create(user_id: @user.id, house_id: @house.id, reservation_date: Time.now)
          
        end

        let(:user_id) { @user.id }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   reservation_date: { type: :date },
                   user_id: { type: :integer },
                   house_id: { type: :integer },
                   required: %w[id user_id house_id reservation_date]
                 }

               }
        run_test!
      end

      response '200', 'Empty array' do
        let(:user_id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/reservations' do
    post 'Book a visit' do
      tags 'Create Visit Reservation'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer, description: 'Current User ID'
      parameter name: :booking, in: :body, schema: {
        type: :object,
        properties: {
          reservation_date: { type: :date },
          user_id: { type: :integer },
          house_id: { type: :integer }
        },
        required: %w[reservation_date user_id house_id]
      }

      response '200', 'Reservation created successfully' do
        before do
          @user = User.create(full_name: 'Mulugeta', email: 'mulu@homely.com', password: 'password')
          @house = House.create(name: 'White house villa', city: 'Addis Ababa', appartment_fee: 2000, description: 'abcde abce', image: 'https://www.house-images.png')
          
        end
        let(:user_id) { @user.id }
        let(:booking) { { user_id: @user.id, house_id: @house.id, reservation_date: Time.now } }
        run_test!
      end
    end
  end
end
