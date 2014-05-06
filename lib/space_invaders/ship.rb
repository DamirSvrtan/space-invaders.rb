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
      unless collides_with?(bullets)
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

    def collides_with?(bullets)
      bullets.each do |bullet|
        if bullet.x_position.between?(self.x_position, self.x_position + self.width) and
           bullet.y_position.between?(self.y_position, self.y_position + self.height)
          self.drowned = true
          bullets.delete(bullet)
          return true
        end
      end
      false
    end
  end
end