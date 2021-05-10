# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  attr_reader :num, :speed, :on_station, :carriages, :type

  NUMBER_REGEXP = /^[a-z\d]{3}-?[a-z]{2}$/i
  MAX_SPEED = 80
  include Company
  include InstanceCounter
  include Validation

  validate :num, :format, NUMBER_REGEXP

  # Не очень понял насколько это правильно, ведь при наследовании @@ тоже наследуется.
  # Получается, что грузовой и пассажирский будут иметь общую переменную, это нормально?

  @@train_instances = []

  class << self
    def all
      @@train_instances
    end

    def find(num)
      Train.all.select { |train| train.num == num }
    end
  end

  def initialize(num, type)
    @num = num
    @type = type
    @carriages = []
    @speed = 0
    validate!
    @@train_instances << self
    register_instance
  end

  # def valid?
  #   validate!
  #   true
  # rescue
  #   false
  # end

  # Общий, чтобы смотреть есть ли у поезда маршрут
  def has_route?
    !@route.nil?
  end

  # Общий по заданию
  def car_count
    @carriages.size
  end

  # Общий, чтобы осуществлять управление поездом
  def run_forward
    run(next_station) if next_station
  end

  # Общий, чтобы осуществлять управление поездом
  def run_backward
    run(previous_station) if previous_station
  end

  # Общий, чтобы узнавать детали маршрута
  def next_station
    @route&.next_station(@on_station)
  end

  # Общий, чтобы узнавать детали маршрута
  def previous_station
    @route&.previous_station(@on_station)
  end

  def for_each_car
    carriages.each do |car|
      yield car
    end
  end
  
  # Общий, чтобы любой мог добавить
  def add_car(car)
    @carriages << car if car.type == type
  end

  # Общий, чтобы любой мог удалить
  def remove_car(car)
    @carriages.delete(car) if car_count
  end

  # Общий, потому что задается извне
  def set_route(route)
    @route = route
    @route.start_st.arrive_train(self)
  end

  # Общий, потому что это использует станция
  def set_station(station)
    @on_station = station
  end

  def to_s
    "Train #{@num}, type: #{@type}, carriages: #{@carriages.length}"
  end

  def inspect
    to_s
  end

  # protected

  # def validate!
    # raise 'Неправильный номер поезда. Номер может состаять из 3 английских букв или цифр, необязательного дефиса и двух английских букв' if @num.match(NUMBER_REGEXP).nil?
    # raise "Невозможный тип поезда. Тип поезда должен быть 'cargo' или 'passenger'" if !['cargo', 'passenger'].include?(@type)
  # end

  private

  # Приватный, потому что достаточно сильный и может посылать на
  def run(to_station)
    @on_station.dispatch_train(self)                           # любую станцию, без проверки логики, его используют только методы,
    @speed = MAX_SPEED                                         # которые проверяют логику
    @speed = 0
    to_station.arrive_train(self)
  end
end
