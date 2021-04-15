# frozen_string_literal: true

class Train
  attr_reader :name, :type, :car_count, :speed, :on_station

  def initialize(num, type, car_count)
    @num = num
    @type = type
    @car_count = car_count >= 0 ? car_count : 0
    @speed = 0
  end

  def has_route?
    !@route.nil?
  end

  def run(to_station)
    @on_station.dispatch_train(self)
    @speed = 80
    @speed = 0
    to_station.arrive_train(self)
  end

  def run_forward
    run(next_station) if next_station
  end

  def run_backward
    run(previous_station) if previous_station
  end

  def next_station
    @route.next_station(@on_station)
  end

  def previous_station
    @route.previous_station(@on_station)
  end

  def add_car
    @car_count += 1
  end

  def remove_car
    @car_count -= 1 if @car_count >= 1
  end

  def set_route(route)
    @route = route
    @route.start_st.arrive_train(self)
  end

  def set_station(station)
    @on_station = station
  end

  def to_s
    "Train #{@num}, type: #{@type}, cars: #{@car_count}"
  end
end
