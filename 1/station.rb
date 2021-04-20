# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by(type)       # Общий по заданию
    @trains.filter { |train| train.type == type }
  end

  def arrive_train(train)   # Общий, потому что поезд при приближении к станции использует этот метод
    @trains << train
    train.set_station(self)
  end

  def dispatch_train(train)               # Общий, потому что поезд использует его при отправлении
    return unless @trains.include? train

    @trains.delete(train) if train.next_station
  end

  def to_s
    "Station #{@name} with trains #{trains}"
  end
end
