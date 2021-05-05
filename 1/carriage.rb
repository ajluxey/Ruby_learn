# frozen_string_literal: true

class Carriage
  attr_reader :type

  include Company

  def initialize(type)
    @type = type
  end

  def to_s
    "#{@type} carriage"
  end

  def inspect
    to_s
  end
end
