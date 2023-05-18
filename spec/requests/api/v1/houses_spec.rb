require 'swagger_helper'

RSpec.describe 'api/v1/houses', type: :request do
  path '/api/v1/houses' do
    get('list houses') do
      tags 'list all of the houses'
      produces 'application/json'
      response '200', 'successful' do
        before do
          @houses = House.create(
            {
              name: 'Rancho',
              city: 'Dallas',
              image: 'www.sample-image.com',
              appartment_fee: 100.0,
              description: 'big place'
            }
          )
        end
        schema type: :object,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   city: { type: :string },
                   image: { type: :string },
                   appartment_fee: { type: :float },
                   description: { type: :string }
                 },
                 required: %w[id name city image appartment_fee description]
               }
        run_test!
      end
    end
  end

  path '/api/v1/houses/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show house') do
      tags 'get single house detail'
      produces 'application/json'

      response(200, 'successful') do
        before do
          @houses = House.create(
            {
              name: 'Rancho',
              city: 'Dallas',
              image: 'www.sample-image.com',
              appartment_fee: 100.0,
              description: 'big place'
            }
          )
        end
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 city: { type: :string },
                 image: { type: :string },
                 appartment_fee: { type: :integer },
                 description: { type: :string }
               },
               required: %w[id name city image appartment_fee description]
        let(:id) { @houses.id }
        run_test!
      end
      response '404', 'invalid url' do
        let(:id) { 'invalid_id' }
        run_test!
      end
    end
  end
end
