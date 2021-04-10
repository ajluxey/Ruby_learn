class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def get_trains
    return @trains
  end
  
  def get_trains_by_type
    type_count = {}
    @trains.each do |train|
      if type_count.include? train.type
        type_count[train.type] += 1
      else 
        type_count[train.type] = 1
      end
    end
    return type_count
  end 
  
  def arrive_train(train)
    if not train.is_a? Train or not train.has_route?
      return 
    end 
    train.stop
    @trains << train
    train.set_station(self)
  end

  def dispatch_train(train, direction)
    if direction != 'forward' and direction != 'backward'
      return
    end
    if not train.is_a? Train or not @trains.include? train
      return 
    end
    tr_next_st = train.next_station(self, direction)
    if tr_next_st
      train.accelerate
      train.set_station(nil)
      tr_next_st.arrive_train(train)
      @trains.delete(train)
    end
  end
  
  def to_s
    return "Station #{@name}"
  end 
end
