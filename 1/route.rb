class Route
  attr_reader :start_st

  def initialize(start_st, end_st)
    @start_st = start_st
    @end_st = end_st
    @between_st = []
  end
  
  def add_station(station)
    if not station.is_a? Station or @between_st.include? station or @start_st == station or @end_st == station
      return
    end 
    @between_st << station
  end 
  
  def delete_station(station)
    if not station.is_a? Station or not @between_st.include? station or @start_st == station or @end_st == station
      return
    end
    @between_st.delete(station)
  end 

  def print_all_stations
    puts "Route has stations:\n#{@start_st}"
    @between_st.each do |station|
      puts station
    end
    puts @end_st
  end

  def next_station(from)
    if from == @end_st or from != @start_st and not @between_st.include?(from)
      return
    elsif from == @start_st
      return @between_st[0]
    else
      indx = @between_st.index(from)
      if indx + 1 == @between_st.size
        return @end_st
      else
        return @between_st[indx + 1]
      end
    end
  end
  
  def previous_station(from)
    if from == @start_st or from != @end_st and not @between_st.include?(from)
      return
    elsif from == @end_st
      return @between_st[-1]
    else
      indx = @between_st.index(from)
      if indx == 0
        return @start_st
      else
        return @between_st[indx - 1]
      end
    end
  end

  def to_s
    "Route #{@start_st} - #{@end_st}"
  end
end
