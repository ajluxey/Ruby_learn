# frozen_string_literal: true

class Route
  attr_reader :start_st

  def initialize(start_st, end_st)
    @start_st = start_st
    @end_st = end_st
    @between_st = []
  end

  def add_station(station)
    @between_st << station unless all_stations.include? station
  end

  def delete_station(station)   # if delete check trains on station. if station has trains each train.route = nil
    @between_st.delete(station) if @between_st.include? station
  end

  def all_stations
    [@start_st, *@between_st, @end_st]
  end

  def next_station(from)
    all_stations[all_stations.index(from) + 1]
  end

  def previous_station(from)
    return if from == @start_st

    all_stations[all_stations.index(from) - 1]
  end

  def to_s
    "Route #{@start_st} - #{@end_st}"
  end
end
