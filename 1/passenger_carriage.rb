require_relative 'carriage'


class PassengerCarriage < Carriage
  def initialize
    super('passenger')
  end
  
  def to_s
    'pass'
  end
end