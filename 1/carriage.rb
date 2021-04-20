class Carriage
  attr_reader :type

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