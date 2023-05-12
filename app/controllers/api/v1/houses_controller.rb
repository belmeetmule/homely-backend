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
    house = House.new(house_params)

    if house.save
      render json: house, status: :created
    else
      render json: house.errors, status: :unproccessable_entity
    end
  end

  private

  def house_params
    params.require(:house).permit(:name, :city, :image, :appartment_fee, :description)
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
