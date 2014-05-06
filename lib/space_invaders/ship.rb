require_relative 'bullet'
require_relative 'bullet_collection'

module SpaceInvaders
  class Ship
    def initialize window
      @window = window
      @image = Gosu::Image.new @window, "images/Ship.png"
      @image_x = @window.width/2 - 40
      @image_y = @window.height - 50
      @bullet_collection = BulletCollection.new
    end

    def update
      if @window.button_down? Gosu::KbLeft
        unless @image_x.between?(0, 20)
          @image_x += -5
        end
      elsif @window.button_down? Gosu::KbRight
        unless @image_x.between?(@window.width - 90, @window.width - 70)
          @image_x += 5
        end
      end
      @bullet_collection.update
    end

    def draw
      @image.draw @image_x, @image_y, 1
      @bullet_collection.draw
    end

    def x_middle
      @image_x + @image.width/2
    end

    def fire!
      bullet = Bullet.new @window, self, true
      @bullet_collection.bullets << bullet
    end

    def bullets
      @bullet_collection
    end
  end
end