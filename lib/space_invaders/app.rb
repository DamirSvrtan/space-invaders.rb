require "gosu"
require 'pry'

# Load the lib if you're running the game without installing the gem.
lib = File.expand_path('../..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'space_invaders/base'
require 'space_invaders/statics/game_status'
require 'space_invaders/screens/welcome_screen'
require 'space_invaders/screens/game_over_screen'
require 'space_invaders/screens/next_level_screen'

require 'space_invaders/trackers/score_tracker'
require 'space_invaders/trackers/lives_tracker'

require 'space_invaders/statics/button_controller'
require 'space_invaders/statics/images'
require 'space_invaders/statics/sounds'

require 'space_invaders/invaders/invaders_container'
require 'space_invaders/invaders/red_invader'

require 'space_invaders/blocks/u_block'
require 'space_invaders/blocks/u_block_container'

require 'space_invaders/ship/ship'
require 'space_invaders/utils'

module SpaceInvaders
  class App < Gosu::Window

    RELATIVE_DEFAULT_FONT = File.join('..', '..', '..', 'assets', 'fonts', 'unifont.ttf')
    DEFAULT_FONT = File.expand_path(RELATIVE_DEFAULT_FONT,__FILE__)

    STATICS = :game_status, :button_controller, :images, :sounds,
              :welcome_screen, :game_over_screen, :next_level_screen
    TRACKERS = :lives_tracker, :score_tracker
    DYNAMICS = :ship, :invaders_container, :u_block_container, :red_invader

    attr_reader *STATICS, *TRACKERS, *DYNAMICS

    def initialize width=800, height=600, fullscreen=false
      super
      self.caption = "Space Invaders"
      initialize_statics
      initialize_dynamics_and_trackers
    end

    def button_down id
      button_controller.button_down id
    end

    def update
      if game_status.drowned_ship?
        ship.update
      elsif game_status.being_played?
        update_dynamics
      end
    end

    def draw
      if game_status.hasnt_started?
        welcome_screen.draw
      elsif game_status.next_level?
        next_level_screen.draw
      elsif game_status.drowned_ship? or game_status.being_played?
        draw_dynamics
        draw_trackers
      elsif game_status.finished?
        game_over_screen.draw
      end
    end

    def initialize_statics
      define_properties *STATICS
    end

    def initialize_dynamics_and_trackers
      define_properties *DYNAMICS, *TRACKERS
    end

    def draw_dynamics
      DYNAMICS.each {|dynamic_element| self.send(dynamic_element).draw}
    end

    def draw_trackers
      TRACKERS.each {|tracker_element| self.send(tracker_element).draw}
    end

    def update_dynamics
      DYNAMICS.each {|dynamic_element| self.send(dynamic_element).update}
    end

    private

      def define_properties(*properties)
        properties.each do |property|
          instance_variable_set "@#{property}", Utils.to_klass(property).new(self)
        end
      end

  end
end
