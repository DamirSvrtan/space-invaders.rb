module SpaceInvaders
  module Sounds

    def ship_hit_sound
      @ship_hit_sound ||= Gosu::Sample.new(self, "assets/sounds/InvaderBullet.wav")
    end
  
    def ship_bullet_sound
      @ship_bullet_sound ||= Gosu::Sample.new(self, "assets/sounds/InvaderBullet.wav")
    end

    def invader_hit_sound
      @invader_hit_sound ||= Gosu::Sample.new(self, "assets/sounds/InvaderBullet.wav")
    end

    def invader_bullet_sound
      @invader_bullet_sound ||= Gosu::Sample.new(self, "assets/sounds/InvaderBullet.wav")
    end

  end
end