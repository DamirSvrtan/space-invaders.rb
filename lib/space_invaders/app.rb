require "gosu"

require_relative 'invaders_container'
require_relative 'ship'
require_relative 'score_tracker'
require_relative 'lives_tracker'
require_relative 'global_timer'
require_relative 'images'
require_relative 'sounds'
require_relative 'base'
require_relative 'game_status'
require_relative 'button_controller'
require_relative 'welcome_screen'
require_relative 'game_over_screen'

module SpaceInvaders
  class App < Gosu::Window
    include Images
    include Sounds

    attr_reader :game_status, :button_controller, :score_tracker, :lives_tracker,
                :invaders_container, :ship, :welcome_screen, :game_over_screen

    def initialize width=800, height=600, fullscreen=false
      super
      self.caption = "Sprite Demonstration"

      @invaders_container = InvadersContainer.new self
      @ship = Ship.new self

      @game_status = GameStatus.new self
      @welcome_screen = WelcomeScreen.new self
      @game_over_screen = GameOverScreen.new self

      @button_controller = ButtonController.new self
      @score_tracker = ScoreTracker.new self
      @lives_tracker = LivesTracker.new self
      # GlobalTimer.start!
    end

    def button_down id
      button_controller.button_down id
    end

    def update
      if game_status.drowned_ship?
        ship.update
      elsif game_status.being_played?
        if invaders_container.any_invaders? and ship.alive?
          invaders_container.update
          ship.update
        end
      end
    end

    def draw
      if game_status.hasnt_started?
        welcome_screen.draw
      elsif game_status.drowned_ship? or game_status.being_played?
        invaders_container.draw
        ship.draw
        score_tracker.draw
        lives_tracker.draw
      elsif game_status.finished?
        game_over_screen.draw
      else
        binding.pry
      end
    end

    def default_font
      "assets/fonts/unifont.ttf"
    end

  end
end