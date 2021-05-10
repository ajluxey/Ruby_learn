# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(history) }
      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get(history).nil?
          instance_variable_set(history, [])
        end
        instance_variable_set(history, instance_variable_get(history) << instance_variable_get(var_name))
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, base)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name)}
    define_method("#{name}=".to_sym) do |value|
      if value.is_a? base
        instance_variable_set(var_name, value) 
      else
        raise TypeError, "#{var_name} type must be #{base}"
      end
    end
  end
end


class Animal
  extend Accessors
  attr_accessor_with_history :name

  def initialize(name)
    @name = name
  end
end


class Test
  extend Accessors
  strong_attr_accessor :pet, Animal

  def initialize(pet)
    @pet = pet
  end
end
