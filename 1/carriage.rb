# frozen_string_literal: true

require_relative 'company'


class Carriage
  attr_reader :type

  include Company

  def initialize(type)
    @type = type
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def to_s
    "#{@type} carriage"
  end

  def inspect
    to_s
  end

  private
  
  def validate!
    raise "Невозможный тип вагона. Тип вагона должен быть 'cargo' или 'passenger'" if !['cargo', 'passenger'].include?(@type)
  end
end
