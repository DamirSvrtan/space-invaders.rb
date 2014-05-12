require 'forwardable'
require_relative 'base'

module SpaceInvaders
  class InvaderRow < Base
    extend Forwardable

    attr_accessor :direction
    attr_reader :invader_clazz

    X_POSITIONS = [40, 110, 180, 250, 320, 390, 460, 530]

    def initialize app, y_position, invader_clazz
      super(app)
      @y_position = y_position
      @direction = :right
      @invader_clazz = invader_clazz
      @invaders = []
      X_POSITIONS.each do |x_position|
        @invaders << invader_clazz.new(app, x_position, y_position)
      end
    end

    def_delegators :@invaders, :each, :count, :select, :find, :empty?

    def update direction, y_offset
      @invaders.each {|invader| invader.update direction, y_offset }
    end

    def draw
      @invaders.each {|invader| invader.draw }
    end

    def farmost_right_position
      @invaders.max_by {|invader| invader.x_position }.x_position
    end

    def farmost_left_position
      @invaders.min_by {|invader| invader.x_position }.x_position
    end

    def check_collision(bullets)
      @invaders.delete_if do |invader|
        if invader.collides_with? bullets
          app.score_tracker.increase_by(invader.points)
          app.sounds.play_invader_hit!
        end
      end
    end

  end
end