class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    reservations = current_user.reservations
    render json: reservations, status: 200
  end

  def create
    # @reservation = Reservation.new(reservation_date: params[:reservation_date], user_id: params[:user_id],
    #                                house_id: params[:house_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render json: @reservation.to_json(include: %i[house])
    else
      render json: {
        status: 404,
        error: @reservation.errors.full_messages
      }
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    if reservation
      reservation.destroy
      render json: {
        status: 200,
        message: 'reservation removed successfully'
      }
    else
      render json: {
        error: reservation.errors.full_messages
      }
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(%i[
                                          reservation_date
                                          user_id
                                          house_id
                                        ])
  end
end
