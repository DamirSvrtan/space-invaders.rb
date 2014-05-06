require_relative 'abstract_vehicle'

module SpaceInvaders
  class Ship < AbstractVehicle

    attr_accessor :drowned
    alias_method :drowned?, :drowned

    def initialize window
      super
      @image = Gosu::Image.new @window, "images/Ship.png"
      @x_position = @window.width/2 - 40
      @y_position = @window.height - 50
      @drowned = false
    end

    def update(bullets)
      if collides_with? bullets 
        self.drowned = true
      else
        if @window.button_down? Gosu::KbLeft
          unless @x_position.between?(0, 20)
            @x_position += -5
          end
        elsif @window.button_down? Gosu::KbRight
          unless @x_position.between?(@window.width - 90, @window.width - 70)
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
    end

  end
end