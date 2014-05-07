module SpaceInvaders
  module InvaderImages
    def invader_a1_image
      @invaderA1Image ||= Gosu::Image.new self, "images/InvaderA1.png"
    end
  
    def invader_a2_image
      @invaderA2Image ||= Gosu::Image.new self, "images/InvaderA2.png"
    end

    def invader_b1_image
      @invaderB1Image ||= Gosu::Image.new self, "images/InvaderB1.png"
    end
  
    def invader_b2_image
      @invaderB2Image ||= Gosu::Image.new self, "images/InvaderB2.png"
    end

    def invader_c1_image
      @invaderC1Image ||= Gosu::Image.new self, "images/InvaderC1.png"
    end
  
    def invader_c2_image
      @invaderC2Image ||= Gosu::Image.new self, "images/InvaderC2.png"
    end
  end
end