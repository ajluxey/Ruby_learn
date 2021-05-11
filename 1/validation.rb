# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *args)
      raise 'Validation type can be :presece, :format, :type' unless [:presence, :format, :type].include? type

      var_name = "@#{name}".to_sym
      var_validators_name = "@var_validators".to_sym
      var_validators = instance_variable_get(var_validators_name)
      if var_validators.nil?
        instance_variable_set(var_validators_name, {})
        var_validators = instance_variable_get(var_validators_name)
      end
      # if !var_validators.key? var_name
      #   instance_variable_set(var_validators_name, {var_name => []})
      #   var_validators = instance_variable_get(var_validators_name)
      # end
      var_validators[var_name] = [] if !var_validators.key? var_name
      var_validators[var_name] << [type, args.first] unless var_validators[var_name].include? [type, args.first]
    end   
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end
    
    protected

    def validate!
      class_with_info = self.class
      while class_with_info.superclass != Object
        class_with_info = class_with_info.superclass
      end

      class_with_info.instance_variable_get("@var_validators".to_sym).each do |var_name, validators|
        value = instance_variable_get(var_name)
        validators.each do |validator, param|
          begin
            self.send validator, value, param
          rescue Exception => e
            raise e.message + " from #{var_name}"
          end
        end
      end
    end

    def presence(value, tmp)
      raise "Presence validation" if value.nil? or value.empty?
    end

    def format(value, regexp)
      raise "Format validation" if value.match(regexp).nil?
    end

    def type(value, valid_type)
      raise "Type validation" if !value.is_a? valid_type
    end
  end
end
  

class Test
  include Validation
  attr_accessor :name
  validate :name, :type, String
  validate :name, :format, /[1-9]*/
  validate :name, :presence
end
