require_relative 'bullet'
require_relative 'bullet_collection'
require_relative 'collideable'

module SpaceInvaders
  class AbstractVehicle < Base
    include Collideable
    

    def initialize app
      @app = app
      @bullet_collection = BulletCollection.new
    end

    def bullets
      @bullet_collection
    end

    def draw
      @image.draw @x_position, @y_position, 1
      @bullet_collection.draw
    end

  end
end