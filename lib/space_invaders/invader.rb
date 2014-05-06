module SpaceInvaders
  class Invader
    attr_accessor :x_position, :y_position
    attr_reader :original_x_position

    def initialize window, x_position, y_position
      @window = window
      @was_first_image = true
      @x_position = x_position
      @original_x_position = x_position
      @y_position = y_position
    end

    def update(direction)
      @was_first_image = !@was_first_image
      offset = direction == :right ? 10 : -10
      @x_position += offset
      @current_image = @was_first_image ? @first_image : @second_image
    end

    def draw
      @current_image.draw @x_position, @y_position, 1
    end

    def points
      raise NotImplementedError.new("You must implement the inherited points method")
    end

    def width
      @current_image.width
    end

    def height
      @current_image.height
    end

    def x_middle
      @x_position + @current_image.width/2
    end

    def collides_with?(bullets)
      bullets.each do |bullet|
        if bullet.x_position.between?(self.x_position, self.x_position + self.width) and bullet.y_position.between?(self.y_position, self.y_position + self.height)
          @window.score_tracker.increase_by(points)
          bullets.delete(bullet)
          return true
        end
      end
      false
    end
  end
end