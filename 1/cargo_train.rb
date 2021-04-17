require_relative 'train'
require_relative 'cargo_carriage'


class CargoTrain < Train
  def initialize(num)
    super(num, 'cargo')
  end
end