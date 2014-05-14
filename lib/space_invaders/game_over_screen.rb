require 'space_invaders/base'
require 'space_invaders/behaviors/centerable'

module SpaceInvaders
  class GameOverScreen < Base
    include Centerable

    attr_reader :game_over_message, :result, :control_index, :press_play

    def initialize app
      super
      @game_over_message = Gosu::Image.from_text app, "G A M E   O V E R", App::DEFAULT_FONT, 50
      @press_play = Gosu::Image.from_text app, "PRESS SPACE TO PLAY AGAIN", App::DEFAULT_FONT, 30
      @press_play_counter = 0
    end

    def draw
      set_result
      horizontal_center_draw game_over_message, 100
      horizontal_center_draw result, 200

      horizontal_center_draw press_play, 300 if press_play_counter.between?(30,60)
      update_press_play_counter
    end

    private

      attr_reader :press_play_counter

      def update_press_play_counter
        if press_play_counter == 60
          @press_play_counter = 0 
        else
          @press_play_counter += 1
        end
      end

      def set_result
        @result ||= Gosu::Image.from_text app, "SCORE: #{app.score_tracker.score}", App::DEFAULT_FONT, 40
      end
  end
end