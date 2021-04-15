load './route.rb'
load './station.rb'
load './train.rb'


def print_stations_of(train)
  puts "#{train}"
  puts [train.previous_station, train.on_station, train.next_station]
end

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

  train2 = Train.new('11', 'gruz', 10)
  train3 = Train.new('18', 'pass', 8)
  train2.set_route(route)
  train3.set_route(route)
  puts stations[0].trains
  puts stations[0].trains_by('gruz')
  (1..5).each do |i|
    train3.run_forward
    if i < 3
      train2.run_forward
    end
  end

  stations.each do |station|
    puts station
    puts "train on station"
    puts station.trains
    puts
    puts "train on station by type: gruz"
    puts station.trains_by('gruz')
    puts
    puts "train on station by type: pass"
    puts station.trains_by('pass')
    puts
  end
end


test