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
  end
end
