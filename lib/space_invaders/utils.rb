module SpaceInvaders
  module Utils
    def self.to_klass(property)
      klass_name = camelcase(property)
      Object.const_get("SpaceInvaders::#{klass_name}")
    end

    def self.camelcase(property)
      property.to_s.split('_').map{|e| e.capitalize}.join
    end

  end
end