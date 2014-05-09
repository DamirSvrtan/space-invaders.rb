require_relative 'invader_collection'
require_relative 'invader_a'
require_relative 'invader_b'
require_relative 'invader_c'

module SpaceInvaders
  class InvadersContainer < Base

    attr_reader :invader_collections

    def initialize app
      super
      create_invader_collections

      @change_time = Time.now
      @can_fire = Time.now
      @direction = :right
      @bullet_collection = BulletCollection.new
      @y_offset = 0
    end

    def bullets
      @bullet_collection
    end

    def update
      return if game_status.drowned_ship?

      check_collision

      if any_invaders? and can_change?
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
        @change_time = Time.now
      end

      if any_invaders? and can_fire?
        firing_invader = fireable_invaders.sample
        bullet = Bullet.new app, firing_invader, false, 5
        @bullet_collection.bullets << bullet
        @can_fire = Time.now
        app.play_invader_fire!
      end

      bullets.update
    end

    def update_direction direction, y_offset
      invader_collections.each do |invader_collection|
        invader_collection.update direction, y_offset
      end
    end

    def can_fire?
      Time.now > @can_fire + 2
    end

    def can_change?
      Time.now > @change_time + 0.25
    end

    def check_collision
      invader_collections.each do |invader_collection|
        invader_collection.check_collision(rival_bullets)
      end
      invader_collections.delete_if {|invader_collection| invader_collection.empty?}
    end

    def draw
      invader_collections.each do |invader_collection|
        invader_collection.draw
      end
      bullets.draw
    end

    def count
      count = 0
      invader_collections.each do |invader_collection|
        count += invader_collection.count
      end
      count
    end

    def any_invaders?
      count != 0
    end

    def no_invaders?
      count == 0
    end

    def fireable_invaders
      InvaderCollection::X_POSITIONS.map do |x_position|
        invader_collections.reverse.map do |invader_collection|
          invader_collection.find {|invader| invader.original_x_position == x_position }
        end.compact.first
      end.compact
    end

    private

      def rival_bullets
        app.ship.bullets
      end

      def create_invader_collections
        @invader_collections = [
          InvaderCollection.new(app, 100, InvaderA),
          InvaderCollection.new(app, 150, InvaderB),
          InvaderCollection.new(app, 200, InvaderB),
          InvaderCollection.new(app, 250, InvaderC),
          InvaderCollection.new(app, 300, InvaderC),
        ]
      end

      def farmost_right_position
        invader_collections.max_by do |invader_collection|
          invader_collection.farmost_right_position
        end.farmost_right_position
      end

      def farmost_left_position
        invader_collections.min_by do |invader_collection|
          invader_collection.farmost_left_position
        end.farmost_left_position
      end
  end
end