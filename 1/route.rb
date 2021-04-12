class Route
  attr_reader :start_st

  def initialize(start_st, end_st)
    @start_st = start_st
    @end_st = end_st
    @between_st = []
  end
  
  def add_station(station)
    if self.all_stations.include? station
      return
    end 
    @between_st << station
  end 
  
  def delete_station(station)
    unless @between_st.include? station
      return
    end
    @between_st.delete(station)
  end 

  def all_stations
    tmp = @between_st.clone
    tmp.insert(0, @start_st) << @end_st
  end

  def next_station(from)
    all_stations = self.all_stations
    all_stations[all_stations.index(from) + 1]
  end
  
  def previous_station(from)
    if from == @start_st
      return
    end
    all_stations = self.all_stations
    all_stations[all_stations.index(from) - 1]
  end

  def to_s
    "Route #{@start_st} - #{@end_st}"
  end
end
