require_relative 'carriage'


class CargoCarriage < Carriage
  def initialize
    super('cargo')
  end
  
  def to_s
    'cargo'
  end
end