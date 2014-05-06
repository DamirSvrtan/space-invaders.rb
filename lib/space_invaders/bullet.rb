module SpaceInvaders
  class Bullet

    attr_reader :x_position, :y_position

    def initialize window, ship, going_up
      @window = window
      @ship = ship
      @image = Gosu::Image.new @window, "images/Bullet.png"
      @x_position = @ship.x_middle - @image.width/2
      @y_position = @window.height - 50
      @going_up = going_up
    end

    def update
      if @going_up
        @y_position -= 10
      else
        @y_position += 10
      end
    end

    def draw
      @image.draw @x_position, @y_position, 1
    end

    def out_of_screen
      if @going_up
        @y_position < 0
      else
        @y_position > @window.height
      end
    end

  end
end