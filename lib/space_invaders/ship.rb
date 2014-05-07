require_relative 'abstract_vehicle'

module SpaceInvaders
  class Ship < AbstractVehicle

    attr_accessor :drowned
    alias_method :drowned?, :drowned


    def initialize application
      super
      @image = @application.ship_image
      @x_position = @application.width/2 - 40
      @y_position = @application.height - 50
      @drowned = false
    end

    def update(bullets)
      if collides_with? bullets
        application.play_ship_hit!
        self.drowned = true
      else
        if @application.button_down? Gosu::KbLeft
          unless @x_position <= 20
            @x_position += -5
          end
        elsif @application.button_down? Gosu::KbRight
          unless @x_position >= @application.width - 90
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
      bullet = Bullet.new @application, self, true
      @bullet_collection.bullets << bullet
      application.play_ship_fire!
    end

  end
end