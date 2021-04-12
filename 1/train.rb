class Train
  attr_reader :name
  attr_reader :type 
  attr_reader :car_count
  attr_reader :speed
  
  def initialize(num, type, car_count)
    @num = num
    @type = type
    @car_count = car_count >= 0? car_count : 0
    @speed = 0
    @route = nil 
    @on_station = nil
    @direction = true   # true => forward, false => backward
  end 
  
  def has_route?
    !@route.nil?
  end
  
  def run
    @speed = 80
    next_station = self.next_station
    next_station.arrive_train(self)
  end

  def stop
    @speed = 0
  end

  def next_station
    return @direction? @route.next_station(@on_station) : @route.previous_station(@on_station)
  end

  def previous_station
    return @direction? @route.previous_station(@on_station) : @route.next_station(@on_station)
  end
  
  def set_direction(direction)
    if direction == 'forward'
      @direction = true
    elsif direction == 'backward'
      @direction = false
    end
  end

  def add_car
    @car_count += 1
  end 
  
  def remove_car
    if @car_count >= 1
      @car_count -= 1
    end 
  end 
  
  def set_route(route)
    @route = route
    @route.start_st.arrive_train(self)
  end
  
  def set_station(station)
    if station.is_a? Station
      @on_station = station
    end
  end

  def get_route_details
    if self.has_route? and @on_station
      return [@route.previous_station(@on_station), @on_station, @route.next_station(@on_station)]
    end
  end
  
  def to_s
    "Train #{@num}, type: #{@type}, cars: #{@car_count}"
  end 
end
