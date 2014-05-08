require_relative 'abstract_vehicle'
require_relative 'drowned_ship_animator'

module SpaceInvaders
  class Ship < AbstractVehicle

    attr_accessor :drowned, :lives, :image, :drowned_ship_animator

    alias_method :drowned?, :drowned

    def initialize app
      super
      @image = app.ship_image
      @x_position = app.width/2 - 40
      @y_position = app.height - 50
      @lives = 3
      @drowned = false
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
          @bullet_collection.update
        end
      end
    end

    def alive?
      !drowned
    end

    def no_more_lives?
      lives == 0
    end

    def fire!
      bullet = Bullet.new @app, self, true
      @bullet_collection.bullets << bullet
      app.play_ship_fire!
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
        if @image == app.ship_crushed_left_image
          @image = app.ship_crushed_right_image
        else
          @image = app.ship_crushed_left_image
        end
      end

      def handle_collision
        app.play_ship_hit!
        decrease_lives!
        if no_more_lives?
          self.drowned = true
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