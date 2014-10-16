module Bystander
  module Util
    def self.snakecase_string string
      string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def self.classify_string string
      string.split('_').collect(&:capitalize).join
    end

    def self.class_method_identifier base, method, args
      "#{base.name}::#{method.name}(#{args.join(', ')})"
    end

    def self.instance_method_identifier base, method, args
      "#{base.class.name}##{method.name}(#{args.join(', ')})"
    end

    def self.identify_method base, method_sym
      base.method method_sym rescue base.instance_method method_sym
    end
  end
end
