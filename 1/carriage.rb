class Carriage
  attr_reader :is_bound
  attr_reader :on_train

  def initialize
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

  def inspect
    to_s
  end
end