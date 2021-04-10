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
  end 
  
  def has_route?
    not @route.nil?
  end
  
  def accelerate
    @speed = 80
  end 
  
  def stop
    @speed = 0
  end

  def next_station(from, direction)
    if direction == 'forward'
      return @route.next_station(from)
    elsif direction == 'backward'
      return @route.previous_station(from)
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
    if route.is_a? Route
      @route = route
      @route.start_st.arrive_train(self)
    end
  end
  
  def set_station(station)
    if station.is_a? Station or station.nil?
      @on_station = station
    end
  end

  def get_route_details
    if self.has_route? or @on_station.nil?
      puts "Train route details:"
      puts "previous station is #{@route.previous_station(@on_station)}"
      puts "on station is #{@on_station}"
      puts "next station is #{@route.next_station(@on_station)}"
    else 
      puts "this train doesn't have route or not on station"
    end
  end
  
  def to_s
    return "Train #{@num}, type: #{@type}, cars: #{@car_count}"
  end 
end
