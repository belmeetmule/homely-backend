class Api::V1::HousesController < ApplicationController
  def index
    @houses = House.all
    render json: @houses, status: :ok
  end

  def show
    house = House.find(params[:id])
    render json: house
  end

  def create
    house = House.create(
      name: params[:houseName],
      city: params[:houseCity],
      image: params[:houseImage],
      appartment_fee: params[:appatmentFee],
      description: params[:houseDesc]
    )
    if house
      render json: {
        status: 200,
        house: house.to_json(only(%i[name city image description]))
      }
    else
      render json: {
        error: house.errors.full_message
      }
    end
  end

  def destroy
    house = House.find(params[:id])
    if house
      house.destroy
      render json: {
        status: 200,
        message: "Successfully removed #{house.name}"
      }
    else
      render json: {
        error: mentor.errors.full_message
      }
    end
  end
end
