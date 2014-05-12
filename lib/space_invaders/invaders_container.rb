require_relative 'invader_row'
require_relative 'invader_abc'
require_relative 'fireable'

module SpaceInvaders
  class InvadersContainer < Base
    include Fireable
    attr_reader :invader_rows

    def initialize app
      super
      create_invader_rows
      @change_time = Time.now
      @can_fire = Time.now
      @direction = :right
      @y_offset = 0
    end

    def update
      check_collision

      if no_invaders?
        app.next_level_screen.timer_start!
        return game_status.next_level!
      end

      if can_change?
        change_direction
        @change_time = Time.now
      end

      if can_fire?
        fire!
        @can_fire = Time.now
      end

      bullets.update
    end

    def draw
      invader_rows.each {|invader_row| invader_row.draw }
      bullets.draw
    end

    def count
      invader_rows.map {|invader_row| invader_row.count}.inject(:+) || 0
    end

    def any_invaders?
      not count.zero?
    end

    def no_invaders?
      count.zero?
    end

    def reinitialize!
      create_invader_rows
      bullets.clear
      rival_bullets.clear
      @change_time = Time.now
      @can_fire = Time.now
    end

    private

      def check_collision
        invader_rows.each { |invader_row| invader_row.check_collision(rival_bullets) }
        invader_rows.delete_if {|invader_row| invader_row.empty?}
        hit_rock_bottom? if any_invaders?
      end

      def hit_rock_bottom?
        if any_invaders? and fireable_invaders.first.y_position == app.height
          app.game_status.finished!
        end
      end

      def change_direction
        if farmost_right_position >= app.width - 80
          @direction = :left
          @y_offset = 10
        elsif farmost_left_position <= 20
          @direction = :right
          @y_offset = 10
        else
          @y_offset = 0
        end
        update_direction(@direction, @y_offset)
      end

      def update_direction direction, y_offset
        invader_rows.each {|invader_row| invader_row.update direction, y_offset }
      end

      def shooter
        fireable_invaders.sample
      end

      def sound
        app.sounds.invader_bullet_sound
      end

      def can_fire?
        Time.now > @can_fire + 2
      end

      def can_change?
        Time.now > @change_time + 0.25
      end

      def fireable_invaders
        InvaderRow::X_POSITIONS.map do |x_position|
          invader_rows.reverse.map do |invader_row|
            invader_row.find {|invader| invader.original_x_position == x_position }
          end.compact.first
        end.compact
      end

      def create_invader_rows
        @invader_rows = [
          InvaderRow.new(app, 100, InvaderA),
          InvaderRow.new(app, 150, InvaderB),
          InvaderRow.new(app, 200, InvaderB),
          InvaderRow.new(app, 250, InvaderC),
          InvaderRow.new(app, 300, InvaderC),
        ]
      end

      def rival_bullets
        app.ship.bullets
      end

      def farmost_right_position
        invader_rows.max_by do |invader_row|
          invader_row.farmost_right_position
        end.farmost_right_position
      end

      def farmost_left_position
        invader_rows.min_by do |invader_row|
          invader_row.farmost_left_position
        end.farmost_left_position
      end
  end
end