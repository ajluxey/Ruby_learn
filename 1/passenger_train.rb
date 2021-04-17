require_relative 'train'
require_relative 'passenger_carriage'


class PassengerTrain < Train
  def add_car(car)
    super(car) if car.is_a? PassengerCarriage
  end
end