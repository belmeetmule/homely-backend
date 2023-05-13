class Api::V1::HousesController < ApplicationController
  def index
    houses = House.all
    render json: houses, status: 200
  end

  def show
    house = House.find_by(id: params[:id])
    if house
      render json: house, status: 200
    else
      render json: {
        error: 'House not found'
      }
    end
  end

  def create
    house = House.new(
      name: house_params[:name],
      city: house_params[:city],
      image: house_params[:image],
      appartment_fee: house_params[:appartment_fee],
      description: house_params[:description]
    )
    if house.save
      render json: house, status: 200
    else
      render json: {
        error: 'Error Creating...'
      }
    end
  end

  def destroy
    house = House.find_by(id: params[:id])
    if house
      house.destroy
      render json: 'House has been deleted'
    end
  end

  private

  def house_params
    params.require(:house).permit(%i[
                                    name
                                    city
                                    image
                                    appartment_fee
                                    description
                                  ])
  end
end
