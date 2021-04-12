class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def get_trains
    @trains
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
    type_count
  end 
  
  def arrive_train(train)
    unless train.has_route?
      return 
    end 
    train.stop
    @trains << train
    train.set_station(self)
  end

  def dispatch_train(train)
    unless @trains.include? train
      return 
    end
    if train.get_route_details[-1]  # do if next station is not nil
      train.run
      @trains.delete(train)
    end
  end
  
  def to_s
    "Station #{@name}"
  end

  def inspect
    return self.to_s
  end
end
