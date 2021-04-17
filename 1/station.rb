# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by(type)
    @trains.filter { |train| train.class == type }
  end

  def arrive_train(train)
    @trains << train
    train.set_station(self)
  end

  def dispatch_train(train)
    return unless @trains.include? train

    @trains.delete(train) if train.next_station
  end

  def to_s
    "Station #{@name}"
  end
end
