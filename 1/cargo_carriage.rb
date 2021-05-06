require_relative 'carriage'


class CargoCarriage < Carriage
  attr_reader :capacity
  attr_reader :fullness

  def initialize(capacity)
    super('cargo')
    @capacity = capacity
    @fullness = 0
  end
  
  def fill(n)
    @fullness += n if fullness + n <= capacity
  end

  def free_volume
    capacity - fullness
  end

  def to_s
    "CargoCar, capacity: #{capacity}, fullness: #{fullness}"
  end
end