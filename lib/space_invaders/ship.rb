require_relative 'bullet'
require_relative 'bullet_collection'

module SpaceInvaders
  class Ship

    attr_accessor :x_position, :y_position

    def initialize window
      @window = window
      @image = Gosu::Image.new @window, "images/Ship.png"
      @x_position = @window.width/2 - 40
      @y_position = @window.height - 50
      @bullet_collection = BulletCollection.new
    end

    def update
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

    def width
      @image.width
    end

    def height
      @image.height
    end

    def draw
      @image.draw @x_position, @y_position, 1
      @bullet_collection.draw
    end

    def x_middle
      @x_position + @image.width/2
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