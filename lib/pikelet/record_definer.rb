module Pikelet
  class RecordDefiner
    attr_reader :file_definition, :definition

    def initialize(file_definition, base_definition: nil)
      @file_definition = file_definition
      @definition = RecordDefinition.new(file_definition, base_definition: base_definition)
    end

    def define(&block)
      if block_given?
        instance_eval(&block)
      end
      definition
    end

    def field(name, index, &block)
      definition.field(name, index, &block)
    end

    def record(type_signature, &block)
      file_definition.record(type_signature, base_definition: definition, &block)
    end

    def method_missing(method, *args, &block)
      field(method, *args, &block)
    end
  end
end
