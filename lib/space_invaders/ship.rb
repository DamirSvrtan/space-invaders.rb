require_relative 'abstract_vehicle'

module SpaceInvaders
  class Ship < AbstractVehicle

    attr_accessor :drowned
    alias_method :drowned?, :drowned

    def initialize window
      super
      @image = @window.ship_image
      @x_position = @window.width/2 - 40
      @y_position = @window.height - 50
      @drowned = false
    end

    def update(bullets)
      if collides_with? bullets
        @window.ship_hit_sound.play
        self.drowned = true
      else
        if @window.button_down? Gosu::KbLeft
          unless @x_position <= 20
            @x_position += -5
          end
        elsif @window.button_down? Gosu::KbRight
          unless @x_position >= @window.width - 90
            @x_position += 5
          end
        end
        @bullet_collection.update
      end
    end

    def alive?
      !drowned
    end

    def fire!
      bullet = Bullet.new @window, self, true
      @bullet_collection.bullets << bullet
      @window.ship_bullet_sound.play
    end

  end
end