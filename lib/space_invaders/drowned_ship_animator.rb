module SpaceInvaders
  class DrownedShipAnimator < Base

    ANIMATION_LENGTH = 3

    attr_accessor :ship

    def initialize(application, ship)
      super(application)
      @ship = ship
    end

    def start!
      @start_time = Time.now
    end

    def animation_time_is_over?
      passed_time > ANIMATION_LENGTH
    end

    def reset!
      @start_time = nil
    end

    def update
      ship.image = if left_image_time?
        app.ship_crushed_left_image
      else
        app.ship_crushed_right_image
      end

      stop_animation if animation_time_is_over?
    end

    private

      def passed_time
        Time.now - @start_time
      end

      def stop_animation
        if ship.no_more_lives?
          app.game_status.finished!
        else
          app.game_status.continue!
        end
      end

      def left_image_time?
        (passed_time * 10 % 10).round(0).even?
      end
  end
end