require_relative 'bullet'
require_relative 'bullet_collection'

module SpaceInvaders
  class AbstractVehicle < Base
    attr_accessor :x_position, :y_position

    def initialize app
      @app = app
      @bullet_collection = BulletCollection.new
    end

    def bullets
      @bullet_collection
    end

    def x_middle
      @x_position + @image.width/2
    end

    def width
      @image.width
    end

    def height
      @image.height
    end

    def draw
      begin
        @image.draw @x_position, @y_position, 1
        @bullet_collection.draw
      rescue
        binding.pry
      end
    end

    def collides_with?(bullets)
      bullets.each do |bullet|
        if bullet.x_position.between?(self.x_position, self.x_position + self.width) and
           bullet.y_position.between?(self.y_position, self.y_position + self.height)
          bullets.delete(bullet)
          return true
        end
      end
      return false
    end

  end
end