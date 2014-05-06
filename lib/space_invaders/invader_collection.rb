module SpaceInvaders
  class InvaderCollection

    attr_accessor :direction
    attr_reader :invader_clazz

    X_POSITIONS = [40, 110, 180, 250, 320, 390, 460, 530]

    def initialize window, y_position, invader_clazz
      @window = window
      @y_position = y_position
      @direction = :right
      @invader_clazz = invader_clazz
      @invaders = []
      X_POSITIONS.each do |x_position|
        invader = invader_clazz.new(window, x_position, y_position)
        @invaders << invader
      end
    end

    def update(direction)
      @invaders.each {|invader| invader.update direction }
    end

    def draw
      @invaders.each {|invader| invader.draw }
    end

    def each(&block)
      @invaders.each(&block)
    end

    def farmost_right_position
      @invaders.max_by {|invader| invader.x_position }.x_position
    end

    def farmost_left_position
      @invaders.min_by {|invader| invader.x_position }.x_position
    end

    def check_collision(bullets)
      @invaders.delete_if do |invader|
        invader.collides_with? bullets
      end
    end

    def count
      @invaders.count
    end

    def empty?
      @invaders.empty?
    end
  end
end