require_relative 'train'
require_relative 'cargo_carriage'


class CargoTrain < Train
  def add_car(car)
    super(car) if car.is_a? CargoCarriage
  end
end