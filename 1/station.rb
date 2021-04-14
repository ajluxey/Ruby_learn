class Station
  attr_reader :name
  attr_reader :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def trains_by(type)
    type_trains = {}
    @trains.each do |train|
      if type_trains.include? train.type
        type_trains[train.type] << train
      else 
        type_trains[train.type] = [train]
      end
    end
    type_trains[type]
  end 
  
  def arrive_train(train)
    @trains << train
    train.set_station(self)
  end

  def dispatch_train(train)
    return unless @trains.include? train
    if train.next_station
      @trains.delete(train)
    end
  end
  
  def to_s
    "Station #{@name}"
  end
end
