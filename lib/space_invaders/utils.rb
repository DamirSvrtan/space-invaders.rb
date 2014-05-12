module SpaceInvaders
  module Utils
    def self.to_klass(property)
      klass_name = camelcase(property)
      Object.const_get("SpaceInvaders::#{klass_name}")
    end

    def self.camelcase(property)
      property.to_s.split('_').map{|e| e.capitalize}.join
    end

    def self.snake_klazz_name(klazz)
        klazz.to_s.split('::').last
                  .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                  .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                  .downcase
    end
  end
end