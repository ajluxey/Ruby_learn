class Carriage
  attr_reader :is_bound, :on_train, :type

  def initialize(type)
    @type = type
    @is_bound = false
  end

  def bound_to(train)
    @on_train = train
    @is_bound = true
  end

  def unbound
    @on_train = nil
    @is_bound = false
  end

  def to_s
    "#{@type} carriage"
  end

  def inspect
    to_s
  end
end