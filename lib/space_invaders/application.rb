require "gosu"
# Dir["lib/space_invaders/*.rb"].each {|file| require "./#{file}" }
require_relative 'invaders_container'
require_relative 'ship'
require_relative 'score_tracker'

module SpaceInvaders
  class Application < Gosu::Window
    attr_reader :score_tracker

    def initialize width=800, height=600, fullscreen=false
      super
      self.caption = "Sprite Demonstration"

      @invaders_container = InvadersContainer.new self
      @ship = Ship.new self
      @score_tracker = ScoreTracker.new self
    end

    def button_down id
      if id == Gosu::KbEscape
        close
      elsif id == Gosu::KbSpace
        @ship.fire!
      end
    end

    def update
      if @invaders_container.any_invaders?
        @invaders_container.update(@ship.bullets)
        @ship.update
      end
      # puts "-------------"
      # @invaders_container.fireable_invaders.each do |inv|
      #   print inv.class
      # end
      # puts "\n-------------"
    end

    def draw
      if @invaders_container.any_invaders?
        @invaders_container.draw
        @ship.draw
      else
        congratulations.draw 100, 100, 1
      end
      @score_tracker.draw
    end

    def congratulations
      @congratulations ||= Gosu::Image.from_text self, "Congratulations!", Gosu.default_font_name, 100
    end
  end
end