module SpaceInvaders
  module Utils
    def self.to_klass(property)
      klass_name = property.to_s.split('_').map{|e| e.capitalize}.join
      Object.const_get("SpaceInvaders::#{klass_name}")
    end
  end
end