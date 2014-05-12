require_relative 'invader'

module SpaceInvaders
  class RedInvader < Invader
    attr_accessor :dead

    alias_method :dead?, :dead

    def initialize app, x_position=0, y_position=50
      @first_image = app.images.red_invader
      @second_image = app.images.red_invader
      @can_move = Time.now
      @direction = :right
      @dead = false
      super
    end

    def points
      100
    end

    def alive?
      not dead?
    end

    def update
      return if dead?

      if collides_with? rival_bullets
        handle_death
      elsif can_move?
        set_direction
        @x_position += @direction == :right ? 10 : -10
        @can_move = Time.now
      end
    end

    def draw
      return if dead?
      @image.draw @x_position, @y_position, 1
    end

    def handle_death
      @dead = true
      app.score_tracker.increase_by(points)
      app.sounds.play_invader_hit!
    end

    def set_direction
      if @x_position >= app.width - 80
        @direction = :left
      elsif @x_position <= 20
        @direction = :right
      end
    end

    def rival_bullets
      app.ship.bullets
    end

    def can_move?
      Time.now - @can_move > 0.1
    end

  end
end