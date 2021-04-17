load './passenger_train.rb'
load './cargo_train.rb'
load './station.rb'
load './route.rb'


class RailwayTest
  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def run
    loop do
      break if main_menu == 'exit_phrase'
    end
  end

  def run_with_seed
    @stations << Station.new("Москва") << Station.new("Хабаровск")
    @routes << Route.new(*@stations)
    ['Новосибирск', 'Краснодар', 'Пермь','Екатеринбург'].each do |name|
      station = Station.new(name)
      @stations << station
      @routes[-1].add_station(station)
    end

    p_train = PassengerTrain.new('14')
    c_train = CargoTrain.new('08')
    @trains << p_train << c_train

    c_train.set_route(@routes[-1])
    p_train.set_route(@routes[-1])
    
    (1..rand(1..10)).each { c_train.add_car(CargoCarriage.new) }
    (1..rand(1..10)).each { p_train.add_car(PassengerCarriage.new) }

    (1..rand(1..(@stations.size - 1))).each { c_train.run_forward }
    (1..rand(1..(@stations.size - 1))).each { p_train.run_forward }
    
    run
  end

  def draw_menu(points)
    points.each_with_index do |point, index|
      puts "#{(index + 1).to_s}. #{point}"
    end
  end

  def menu(points)
    draw_menu(points)
    point = gets.chomp.to_i
    unless (1..points.size).include? point
      puts 'Неверное значение, попробуйте снова'
      return menu(points)
    else
      return point
    end
  end

  def main_menu
    menu_points = ['Создать', 'Обновить и использовать методы', 'Объекты', 'Выйти']
    action = menu(menu_points)
    case action
    when 1
      create_object
    when 2
      update_object
    when 3
      print_objects
    when 4
      return 'exit_phrase'
    else
      puts 'smth strange'
    end
  end

  def create_object
    menu_points = ["Станция", "Поезд", "Маршрут"]
    obj = menu(menu_points)
    case obj
    when 1
      create_station
    when 2
      create_train
    when 3
      create_route
    end
  end

  def create_station
    puts "Введите имя станции"
    name = gets.chomp
    @stations << Station.new(name)
    @stations[-1]
  end

  def create_train
    train_class = ["Пассажирский", "Грузовой"]
    train_class = menu(train_class)
    puts "Введите номер поезда:"
    num = gets.chomp
    if train_class == 1
      @trains << PassengerTrain.new(num)
    else
      @trains << CargoTrain.new(num)
    end
    @trains[-1]
  end

  def create_route
    return if @stations.size < 2
    puts "Выберите начальную станцию"
    indx = menu(@stations)
    start_st = @stations[indx - 1]
    tmp_stations = @stations - [start_st]
    puts "Выберите конечную станцию"
    indx = menu(tmp_stations)
    end_st = tmp_stations[indx-1]
    @routes << Route.new(start_st, end_st)
    @routes[-1]
  end

  def update_object
    menu_points = ["Cтанция", "Поезд", "Маршрут"]
    obj = menu(menu_points)
    case obj
    when 1
      if @stations.empty?
        puts "Нет станций"
      else
        update_and_methods_of_station
      end
    when 2
      if @trains.empty?
        puts "Нет поездов"
      else
        update_and_methods_of_train
      end
    when 3
      if @routes.empty?
        puts "Нет маршрутов"
      else
        update_and_methods_of_route
      end  
    end
  end

  def update_and_methods_of_station
    puts "Выберите нужную:"
    station = @stations[menu(@stations) - 1]
    menu_points = ["Список поездов на станции"]
    act = menu(menu_points)
    case act
    when 1
      puts station.trains
    end
  end

  def update_and_methods_of_train
    puts "Выберите нужный:"
    train = @trains[menu(@trains) - 1]
    menu_points = ["Задать маршрут", "Информация", "Отправить вперед", "Отправить назад", "Добавить вагон", "Отцепить вагон"]
    act = menu(menu_points)
    case act
    when 1
      if @routes.empty?
        puts "Маршрутов нет"
      else
        puts "Выберите маршрут из списка"
        route = @routes[menu(@routes) - 1]
        train.set_route(route)
      end
    when 2
      if train.has_route?
        puts "prev: #{train.previous_station}"
        puts "now:  #{train.on_station}"
        puts "next: #{train.next_station}"
      else
        puts "Поезд не имеет маршрута, информация недоступна"
      end
    when 3
      if train.has_route?
        if train.next_station
          train.run_forward
        else
          puts "Движение вперед невозможно"
        end 
      else
        puts "Поезд не имеет маршрута, движение невозможно"
      end
    when 4
      if train.has_route?
        if train.previous_station
          train.run_backward
        else
          puts "Движение назад невозможно"
        end 
      else
        puts "Поезд не имеет маршрута, движение невозможно"
      end
    when 5
      if train.is_a? PassengerTrain
        train.add_car(PassengerCarriage.new)
      else
        train.add_car(CargoCarriage.new)
      end
    when 6
      train.remove_car(train.carriages[-1])
    end
  end

  def update_and_methods_of_route
    puts "Выберите нужный:"
    route = @routes[menu(@routes) - 1]
    menu_points = ["Вывести все станции", "Добавить станцию", "Удалить станцию"]
    act = menu(menu_points)
    case act
    when 1
      puts route.all_stations
    when 2
      stations = @stations - route.all_stations
      if stations.size == 0
        puts "Нет свободных станций, создайте новую"
        station_to_add = create_station
      else
        station_to_add = stations[menu(stations) - 1]
      end
      route.add_station(station_to_add)
    when 3
      stations = route.all_stations
      route.delete(stations[menu(stations) - 1])
    end
  end

  def print_objects
    puts "\nStations:"
    puts @stations
    puts "\nTrains:"
    puts @trains
    puts "\nRoutes:"
    puts @routes
  end    
end


RailwayTest.new.run_with_seed