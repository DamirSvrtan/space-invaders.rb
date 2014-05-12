module SpaceInvaders
  class Bullet < Base

    attr_reader :x_position, :y_position, :going_down, :bullet_offset, :bullet_collection, :image, :fireing_vehicle

    alias_method :going_down?, :going_down

    def initialize fireing_vehicle, going_down, bullet_collection, bullet_offset=10
      super(fireing_vehicle.app)
      @fireing_vehicle = fireing_vehicle
      @image = app.images.bullet
      @bullet_offset = bullet_offset
      @going_down = going_down
      @bullet_collection = bullet_collection
      @bullet_collection << self
      set_position
    end

    def update
      @y_position += going_down? ? bullet_offset : -bullet_offset
    end

    def draw
      image.draw x_position, y_position, 1
    end

    def delete
      bullet_collection.delete(self)
    end

    def out_of_screen
      if going_down
        y_position > app.height
      else
        y_position < 0
      end
    end

    def set_position
      @x_position = fireing_vehicle.x_middle - image.width/2
      @y_position = fireing_vehicle.y_position
      @y_position += fireing_vehicle.height if going_down
    end

  end
end