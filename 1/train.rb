# frozen_string_literal: true

class Train
  attr_reader :name, :speed, :on_station, :carriages
  MAX_SPEED = 80

  def initialize(num)
    @num = num
    @carriages = []
    @speed = 0
  end

  def has_route?
    !@route.nil?
  end

  def car_count
    @carriagess.size
  end

  def run_forward       # Общий, чтобы осуществлять управление поездом
    run(next_station) if next_station
  end

  def run_backward      # Общий, чтобы осуществлять управление поездом
    run(previous_station) if previous_station
  end

  def next_station      # Общий, чтобы узнавать детали маршрута
    @route.next_station(@on_station)
  end

  def previous_station  # Общий, чтобы узнавать детали маршрута
    @route.previous_station(@on_station)
  end

  def add_car(car)      # Общий, чтобы любой мог добавить
    car.bound_to(self)
    @carriages << car
  end

  def remove_car(car)   # Общий, чтобы любой мог удалить
    if car_count
      @carriages.delete(car)
      car.unbound
    end
  end

  def set_route(route)  # Общий, потому что задается извне
    @route = route
    @route.start_st.arrive_train(self)
  end

  def set_station(station)    # Общий, потому что это использует станция
    @on_station = station
  end

  def to_s
    "Train #{@num}, carriages: #{@carriages}"
  end

  private

  def run(to_station)                   # Приватный, потому что достаточно сильный и может посылать на
    @on_station.dispatch_train(self)    # любую станцию, без проверки логики, его используют только методы,
    @speed = MAX_SPEED                  # которые проверяют логику
    @speed = 0
    to_station.arrive_train(self)
  end
end
