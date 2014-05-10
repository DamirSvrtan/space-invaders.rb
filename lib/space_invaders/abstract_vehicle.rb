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
      @image.draw @x_position, @y_position, 1
      @bullet_collection.draw
    end

    def collides_with?(bullets)
      bullets.each do |bullet|
        if got_hit_by? bullet
          bullets.delete(bullet)
          return true
        end
      end
      return false
    end

    def got_hit_by?(bullet)
      bullet.x_position.between?(x_position, x_position + width) and
      bullet.y_position.between?(y_position, y_position + height)
    end

  end
end