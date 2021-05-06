require_relative 'carriage'


class PassengerCarriage < Carriage
  attr_reader :seats
  attr_reader :free_seats

  def initialize(seats)
    super('passenger')
    @seats = seats
    @free_seats = seats
  end
  
  def take_the_seat
    @free_seats -= 1 if free_seats > 0
  end

  def occupied_seats
    seats - free_seats
  end

  def to_s
    "PassCar, seats: #{seats}, free: #{free_seats}"
  end
end