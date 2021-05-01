# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.singleton_class.send(:attr_accessor, :instance_count)
  end

  module ClassMethods
    def instances
      @instance_count ||= 0
    end
  end

  module InstanceMethods
    def register_instance
      if self.class.instance_count.nil?
        self.class.instance_count = 1
      else
        self.class.instance_count += 1
      end
    end
  end
end
