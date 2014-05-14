require 'space_invaders/ship/drowned_ship_animator'
require 'space_invaders/behaviors/mesurable'
require 'space_invaders/behaviors/collideable'
require 'space_invaders/behaviors/fireable'
module SpaceInvaders
  class Ship < Base
    include Mesurable
    include Fireable
    include Collideable

    attr_accessor :lives, :image, :drowned_ship_animator

    def initialize app
      super
      @image = app.images.ship
      @x_position = app.width/2 - 40
      @y_position = app.height - 50
      @lives = 3
      @drowned_ship_animator = DrownedShipAnimator.new app, self
    end

    def update
      if game_status.drowned_ship?
        drowned_ship_animator.update
      else
        if collides_with? rival_bullets
          handle_collision
        else
          move_ship
          bullet_collection.update
        end
      end
    end

    def no_more_lives?
      lives == 0
    end

    def shooter
      self
    end

    def sound
      app.sounds.ship_bullet_sound
    end

    def bullets_going_down?
      false
    end

    def bullet_offset_speed
      10
    end

    def draw
      @image.draw @x_position, @y_position, 1
      bullet_collection.draw
    end

    private

      def rival_bullets
        app.invaders_container.bullets
      end

      def decrease_lives!
        @lives -= 1
        app.lives_tracker.decrease_lives!
      end

      def animate_drowned_ship!
        if @image == app.images.ship_crushed_left
          @image = app.images.ship_crushed_right
        else
          @image = app.images.ship_crushed_left
        end
      end

      def handle_collision
        app.sounds.play_ship_hit!
        decrease_lives!
        if no_more_lives?
          game_status.finished!
        else
          drowned_ship_animator.start!
          game_status.drowned_ship!
        end
      end

      def move_ship
        if app.button_down? Gosu::KbLeft and x_position > 20
          @x_position += -5
        elsif app.button_down? Gosu::KbRight and x_position < app.width - 90
          @x_position += 5
        end
      end

  end
end