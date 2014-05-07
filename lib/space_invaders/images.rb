module SpaceInvaders
  module Images
    def invader_a1_image
      @invader_a1_image ||= Gosu::Image.new self, "images/InvaderA1.png"
    end
  
    def invader_a2_image
      @invader_a2_image ||= Gosu::Image.new self, "images/InvaderA2.png"
    end

    def invader_b1_image
      @invader_b1_image ||= Gosu::Image.new self, "images/InvaderB1.png"
    end
  
    def invader_b2_image
      @invader_b2_image ||= Gosu::Image.new self, "images/InvaderB2.png"
    end

    def invader_c1_image
      @invader_c1_image ||= Gosu::Image.new self, "images/InvaderC1.png"
    end
  
    def invader_c2_image
      @invader_c2_image ||= Gosu::Image.new self, "images/InvaderC2.png"
    end

    def ship_image
      @ship_image ||= Gosu::Image.new self, "images/Ship.png"
    end

    def bullet_image
      @bullet_image ||= Gosu::Image.new self, "images/Bullet.png"
    end
  end
end