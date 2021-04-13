load './route.rb'
load './station.rb'
load './train.rb'


def test
  stations = (1..5).map { |i| Station.new(i.to_s) }
  route = Route.new(stations[0], stations[4])
  stations[1..3].each do |station|
    route.add_station(station)
  end
  puts "All stations in #{route}"
  puts route.all_stations
  train = Train.new('14', 'gruz', 5)
  train.set_route(route)

  puts "\nEvery station dispatch train and fifth too"
  puts "#{train} route details"
  puts [train.previous_station, train.on_station, train.next_station]
  stations.each do |station|
    puts "\n\n#{station} dispatch train\n"
    station.dispatch_train(train)
  end

  puts "Trains on station"
  stations.each do |station|
    puts station
    puts station.get_trains
    puts station.trains_by('gruz')
  end

  puts 'Delete Station 4'
  route.delete_station(stations[3])
  stations.delete_at(3)

  puts "All stations in #{route}"
  puts route.all_stations

  puts stations[0].get_trains
  puts stations[0].trains_by('gruz')
  puts train
  train.add_car
  puts train
  puts train.speed
  (1..10).each { train.remove_car }
  puts train
end


test