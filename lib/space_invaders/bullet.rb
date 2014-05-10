module SpaceInvaders
  class Bullet < Base

    attr_reader :x_position, :y_position

    def initialize app, fireing_vehicle, going_down, bullet_offset=10
      super(app)
      @fireing_vehicle = fireing_vehicle
      @image = app.bullet_image
      @bullet_offset = bullet_offset
      @going_down = going_down

      @x_position = @fireing_vehicle.x_middle - @image.width/2
      @y_position = fireing_vehicle.y_position
      @y_position += fireing_vehicle.height if going_down
    end

    def update
      @y_position += @going_down ? @bullet_offset : -@bullet_offset
    end

    def draw
      @image.draw @x_position, @y_position, 1
    end

    def out_of_screen
      if @going_down
        @y_position > @app.height
      else
        @y_position < 0
      end
    end

  end
end