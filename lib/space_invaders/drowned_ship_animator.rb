module SpaceInvaders
  class DrownedShipAnimator < Base

    ANIMATION_LENGTH_IN_SECONDS = 2

    attr_accessor :ship

    def initialize(app, ship)
      super(app)
      @ship = ship
    end

    def start!
      @start_time = Time.now
    end

    def animation_time_is_over?
      passed_time > ANIMATION_LENGTH_IN_SECONDS
    end

    def reset!
      @start_time = nil
    end

    def update
      ship.image = if animation_time_is_over?
        app.game_status.continue!
        app.ship_image
      elsif left_image_time?
        app.ship_crushed_left_image
      else
        app.ship_crushed_right_image
      end
    end

    private

      def passed_time
        Time.now - @start_time
      end

      def left_image_time?
        (passed_time * 10 % 10).rounds.even?
      end
  end
end