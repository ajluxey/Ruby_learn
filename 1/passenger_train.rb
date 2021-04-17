require_relative 'train'
require_relative 'passenger_carriage'


class PassengerTrain < Train
  def initialize(num)
    super(num, 'passenger')
  end
end