require_relative 'invader_collection'
require_relative 'invader_a'
require_relative 'invader_b'
require_relative 'invader_c'

module SpaceInvaders
  class InvadersContainer < Base

    attr_reader :invader_collections

    def initialize application
      @application = application
      create_invader_collections

      @change_time = Time.now
      @can_fire = Time.now
      @direction = :right
      @bullet_collection = BulletCollection.new
    end

    def bullets
      @bullet_collection
    end

    def update(bullets)
      return if game_status.drowned_ship?

      check_collision(bullets)

      if any_invaders? and can_change?
        if farmost_right_position >= application.width - 80
          @direction = :left
        elsif farmost_left_position <= 20
          @direction = :right
        end

        update_direction(@direction)
        @change_time = Time.now
      end

      if any_invaders? and can_fire?
        firing_invader = fireable_invaders.sample
        bullet = Bullet.new application, firing_invader, false, 5
        @bullet_collection.bullets << bullet
        @can_fire = Time.now
        application.play_invader_fire!
      end

      @bullet_collection.update
    end

    def update_direction direction
      invader_collections.each do |invader_collection|
        invader_collection.update direction
      end
    end

    def can_fire?
      Time.now > @can_fire + 2
    end

    def can_change?
      Time.now > @change_time + 0.25
    end

    def check_collision(bullets)
      @invader_collections.each do |invader_collection|
        invader_collection.check_collision(bullets)
      end
      @invader_collections.delete_if {|invader_collection| invader_collection.empty?}
    end

    def draw
      @invader_collections.each do |invader_collection|
        invader_collection.draw
      end
      @bullet_collection.draw
    end

    def count
      count = 0
      @invader_collections.each do |invader_collection|
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
        @invaders_c.find { |invader| invader.original_x_position == x_position } ||
        @invaders_b.find { |invader| invader.original_x_position == x_position } ||
        @invaders_a.find { |invader| invader.original_x_position == x_position }
      end.compact
    end

    private

      def create_invader_collections
        @invaders_a = InvaderCollection.new application, 200, InvaderA
        @invaders_b = InvaderCollection.new application, 250, InvaderB
        @invaders_c = InvaderCollection.new application, 300, InvaderC

        @invader_collections = [ @invaders_a, @invaders_b, @invaders_c ]
      end

      def farmost_right_position
        fireable_invaders
        @invader_collections.max_by do |invader_collection|
          invader_collection.farmost_right_position
        end.farmost_right_position
      end

      def farmost_left_position
        @invader_collections.min_by do |invader_collection|
          invader_collection.farmost_left_position
        end.farmost_left_position
      end
  end
end