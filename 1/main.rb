load './route.rb'
load './station.rb'
load './train.rb'


def test
  stations = (1..5).map { |i| Station.new(i.to_s) }
  route = Route.new(stations[0], stations[4])
  stations[1..3].each do |station|
    route.add_station(station)
  end 
  route.print_all_stations
  train = Train.new('14', 'gruz', 5)
  train.set_route(route)

  puts "\nEvery station dispatch train forward and fifth too"
  train.get_route_details
  stations.each do |station|
    puts "\n\n#{station} dispatch train\n"
    station.dispatch_train(train, 'forward')
    train.get_route_details
  end

  route.delete_station(stations[3])
  stations.delete_at(3)
  route.print_all_stations

  puts "\nEvery station dispatch train backward and first too"
  
  stations.reverse_each do |station|
    puts "\n#{station} dispatch train\n"
    station.dispatch_train(train, 'backward')
    train.get_route_details
  end

  puts stations[0].get_trains
  puts stations[0].get_trains_by_type
  puts train
  train.add_car
  puts train
  puts train.speed
  (1..10).each { train.remove_car }
  puts train
end


test