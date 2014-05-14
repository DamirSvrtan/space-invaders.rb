require_relative 'base'
require 'space_invaders/behaviors/centerable'

module SpaceInvaders
  class NextLevelScreen < Base
    include Centerable

    attr_reader :next_level_message

    def initialize app
      super
      @next_level_message = Gosu::Image.from_text app, "NEXT LEVEL", App::DEFAULT_FONT, 50
    end

    def draw
      if time_passed?
        timer_stop!
        game_status.continue!
      else
        horizontal_center_draw next_level_message, 300
      end
    end

    def timer_start!
      @timeout = Time.now
    end

    def timer_stop!
      app.invaders_container.reinitialize!
      @timeout = nil
    end

    private

      def time_passed?
        Time.now - @timeout > 3
      end
  end
end