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
      presence_val = Proc.new {|value|  raise "Presence validation" if value.nil? or value.empty?}
      format_val = Proc.new {|value, regexp| raise "Format validation" if value.match(regexp).nil?}
      type_val = Proc.new {|value, valid_type| raise "Type validation" if !value.is_a? valid_type}
      validation_func = {:presence => presence_val,
                         :format => format_val,
                         :type => type_val}

      class_with_info = self.class
      while class_with_info.superclass != Object
        class_with_info = class_with_info.superclass
      end

      # self.class
      class_with_info.instance_variable_get("@var_validators".to_sym).each do |var_name, validators|
        begin
          value = instance_variable_get(var_name)
          validators.each {|validator, param| validation_func[validator].call(value, param)}
        rescue Exception => e
          raise e.message + " from #{var_name}"
        end
      end
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


  # presence_val = Proc.new {|value|  raise "Presence validation" if value.nil? or value.empty?}
  # format_val = Proc.new {|value, regexp| raise "Format validation" if value.match(regexp).nil?}
  # type_val = Proc.new {|value, valid_type| raise "Type validation" if !value.is_a? valid_type}
  # VALIDATION_FUNC = {:presence => presence_val,
  #                   :format => format_val,
  #                   :type => type_val}

  # module ClassMethods
  #   def validate(name, type, *args)
  #     raise 'Validation type can be :presece, :format, :type' unless [:presence, :format, :type].include? type
      
  #     var_validators = "@#{name}_validators".to_sym
  #     if instance_variable_get(var_validators).nil?
  #       instance_variable_set(var_validators, [[type, args]])
  #     else
  #       instance_variable_get(var_validators) << [type, args]
  #     end

  #     define_method("#{name}=".to_sym) do |value|
  #       self.class.instance_variable_get(var_validators).each do |validator, args|
  #         VALIDATION_FUNC[validator].call(value, args.first)
  #       end
  #       instance_variable_set("@#{name}".to_sym, value)
  #     end
  #   end
  # end