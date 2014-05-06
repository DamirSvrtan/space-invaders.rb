require "gosu"
# Dir["lib/space_invaders/*.rb"].each {|file| require "./#{file}" }
require_relative 'invaders_container'
require_relative 'ship'
require_relative 'score_tracker'
require_relative 'global_timer'

module SpaceInvaders
  class Application < Gosu::Window
    attr_reader :score_tracker

    def initialize width=800, height=600, fullscreen=false
      super
      self.caption = "Sprite Demonstration"

      @invaders_container = InvadersContainer.new self
      @ship = Ship.new self
      @score_tracker = ScoreTracker.new self
      GlobalTimer.start!
    end

    def button_down id
      if id == Gosu::KbEscape
        close
      elsif id == Gosu::KbSpace
        @ship.fire!
      end
    end

    def update
      if @invaders_container.any_invaders? and @ship.alive?
        @invaders_container.update(@ship.bullets)
        @ship.update(@invaders_container.bullets)
      end
    end

    def draw
      if @ship.drowned?
        GlobalTimer.stop!
        game_over.draw 100, 100, 1
      elsif @invaders_container.no_invaders?
        GlobalTimer.stop!
        congratulations.draw 100, 100, 1
      else
        @invaders_container.draw
        @ship.draw
      end
      timer.draw 200, 10, 1
      @score_tracker.draw
    end

    def congratulations
      @congratulations ||= Gosu::Image.from_text self, "Congratulations!", Gosu.default_font_name, 100
    end

    def game_over
      @game_over ||= Gosu::Image.from_text self, "Game Over", Gosu.default_font_name, 100
    end

    def timer
      Gosu::Image.from_text self, "Time: #{GlobalTimer.time}", Gosu.default_font_name, 30
    end
  end
end