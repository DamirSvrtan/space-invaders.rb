require 'space_invaders/base'
module SpaceInvaders
  class Sounds < Base

    def ship_hit_sound
      @ship_hit_sound ||= Gosu::Sample.new(app, asset_path('ShipHit'))
    end

    def ship_bullet_sound
      @ship_bullet_sound ||= Gosu::Sample.new(app, asset_path('ShipBullet'))
    end

    def invader_hit_sound
      @invader_hit_sound ||= Gosu::Sample.new(app, asset_path('InvaderHit'))
    end

    def invader_bullet_sound
      @invader_bullet_sound ||= Gosu::Sample.new(app, asset_path('InvaderBullet'))
    end

    def play_ship_hit!
      ship_hit_sound.play volume=0.5
    end

    def play_ship_fire!
      ship_bullet_sound.play volume=0.05
    end

    def play_invader_hit!
      invader_hit_sound.play volume=0.5
    end

    def play_invader_fire!
      invader_bullet_sound.play volume=0.05
    end

    private

      RELATIVE_SOUNDS_PATH = File.join('..', '..', '..', '..', 'assets', 'sounds')

      ABSOLUTE_SOUNDS_PATH = File.expand_path(RELATIVE_SOUNDS_PATH, __FILE__)

      def asset_path(sound_name)
        File.join(ABSOLUTE_SOUNDS_PATH, "#{sound_name}.wav")
      end
  end
end