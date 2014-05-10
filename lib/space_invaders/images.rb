module SpaceInvaders
  module Images
    def invader_a1_image
      @invader_a1_image ||= Gosu::Image.new self, "assets/images/InvaderA1.png"
    end
  
    def invader_a2_image
      @invader_a2_image ||= Gosu::Image.new self, "assets/images/InvaderA2.png"
    end

    def invader_b1_image
      @invader_b1_image ||= Gosu::Image.new self, "assets/images/InvaderB1.png"
    end
  
    def invader_b2_image
      @invader_b2_image ||= Gosu::Image.new self, "assets/images/InvaderB2.png"
    end

    def invader_c1_image
      @invader_c1_image ||= Gosu::Image.new self, "assets/images/InvaderC1.png"
    end
  
    def invader_c2_image
      @invader_c2_image ||= Gosu::Image.new self, "assets/images/InvaderC2.png"
    end

    def red_invader_image
      @invader_d_image ||= Gosu::Image.new self, "assets/images/InvaderD.png"
    end

    def ship_image
      @ship_image ||= Gosu::Image.new self, "assets/images/Ship3.png"
    end

    def ship_crushed_left_image
      @ship_crushed_left_image ||= Gosu::Image.new self, "assets/images/ShipLeft.png"
    end

    def ship_crushed_right_image
      @ship_crushed_right_image ||= Gosu::Image.new self, "assets/images/ShipRight.png"
    end

    def bullet_image
      @bullet_image ||= Gosu::Image.new self, "assets/images/Bullet.png"
    end

    def full_block_image
      @full_block_image ||= Gosu::Image.new self, "assets/images/FullBlock.png"
    end

    def ok_block_image
      @ok_block_image ||= Gosu::Image.new self, "assets/images/OkBlock.png"
    end

    def weak_block_image
      @weak_block_image ||= Gosu::Image.new self, "assets/images/WeakBlock.png"
    end

  end
end