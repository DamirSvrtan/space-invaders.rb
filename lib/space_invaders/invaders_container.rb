require_relative 'invader_collection'
require_relative 'invaderz'

module SpaceInvaders
  class InvadersContainer

    attr_reader :invader_collections

    def initialize window
      @window = window

      @invaders_a = InvaderCollection.new @window, 200, InvaderA
      @invaders_b = InvaderCollection.new @window, 250, InvaderB
      @invaders_c = InvaderCollection.new @window, 300, InvaderC

      @invader_collections = []
      @invader_collections << @invaders_a
      @invader_collections << @invaders_b
      @invader_collections << @invaders_c

      @change_time = Time.now
      @direction = :right
    end

    def update(bullets)
      check_collision(bullets)
      if can_change and any_invaders?
        if farmost_right_position >= @window.width - 80
          @direction = :left
        elsif farmost_left_position <= 20
          @direction = :right
        end
        @invader_collections.each {|invader_collection| invader_collection.update @direction }
        @change_time = Time.now
      end
    end

    def can_change
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

    private

      def farmost_right_position
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