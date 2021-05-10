# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'

class Route
  attr_reader :start_st

  include InstanceCounter
  include Validation

  validate :start_st, :type, Station
  validate :end_st, :type, Station

  def initialize(start_st, end_st)
    @start_st = start_st
    @end_st = end_st
    @between_st = []
    validate!
    register_instance
  end

  # Общий, потому что любой может добавлять станции
  def add_station(station)
    @between_st << station unless all_stations.include? station
  end

  # Общий, потому что любой может удалять станции
  def delete_station(station)
    @between_st.delete(station) if @between_st.include? station
  end

  # Общий, потому что любой может посмотреть станции
  def all_stations
    [@start_st, *@between_st, @end_st]
  end

  # Общий, потому что поезд вызывает этот метод для того чтобы узнать свою следуюзую станцию
  def next_station(from)
    all_stations[all_stations.index(from) + 1]
  end

  # Общий, логика та же что и метода у next_station
  def previous_station(from)
    return if from == @start_st

    all_stations[all_stations.index(from) - 1]
  end

  def to_s
    "Route #{@start_st} - #{@end_st}"
  end
end
