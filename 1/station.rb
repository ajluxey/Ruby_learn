# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Station
  attr_reader :name, :trains

  include InstanceCounter
  include Validation

  validate :name, :presence

  @@created_instances = []

  def self.all
    @@created_instances
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@created_instances << self
    register_instance
  end

  # def valid?
  #   validate!
  #   true
  # rescue
  #   false
  # end 

  def for_each_train
    trains.each do |train|
      yield train
    end
  end

  # Общий по заданию
  def trains_by(type)
    @trains.filter { |train| train.type == type }
  end

  # Общий, потому что поезд при приближении к станции использует этот метод
  def arrive_train(train)
    @trains << train
    train.set_station(self)
  end

  # Общий, потому что поезд использует его при отправлении
  def dispatch_train(train)
    return unless @trains.include? train

    @trains.delete(train) if train.next_station
  end

  def to_s
    "Station #{@name} with trains #{trains}"
  end

  # private

  # def validate!
  #   raise TypeError.new 'Название станции должно быть строкой' if !@name.instance_of?(String)
  # end
end
