class CarsController < ActionController::Base
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find_by(:id => params[:id])
    if @car.nil?
      render json: {}, status: 404
    end
  end
end