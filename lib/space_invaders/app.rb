require "gosu"
require_relative 'invaders_container'
require_relative 'ship'
require_relative 'score_tracker'
require_relative 'lives_tracker'
require_relative 'images'
require_relative 'sounds'
require_relative 'base'
require_relative 'game_status'
require_relative 'button_controller'
require_relative 'welcome_screen'
require_relative 'game_over_screen'
require_relative 'red_invader'
require_relative 'u_block'
require_relative 'u_block_container'

module SpaceInvaders
  class App < Gosu::Window
    include Images
    include Sounds

    DEFAULT_FONT = "assets/fonts/unifont.ttf"

    STATICS = :game_status, :button_controller, :welcome_screen, :game_over_screen
    DYNAMICS = :ship, :invaders_container, :lives_tracker, :u_block_container, :red_invader, :score_tracker

    attr_reader *STATICS, *DYNAMICS

    def initialize width=800, height=600, fullscreen=false
      super
      self.caption = "Sprite Demonstration"
      initialize_statics
      initialize_dynamics
    end

    def button_down id
      button_controller.button_down id
    end

    def update
      if game_status.drowned_ship?
        ship.update
      elsif game_status.being_played?
        if invaders_container.any_invaders?
          invaders_container.update
          ship.update
          red_invader.update
          u_block_container.update
        end
      end
    end

    def draw
      if game_status.hasnt_started?
        welcome_screen.draw
      elsif game_status.drowned_ship? or game_status.being_played?
        draw_dynamics
      elsif game_status.finished?
        game_over_screen.draw
      end
    end

    def initialize_statics
      define_properties *STATICS
    end

    def initialize_dynamics
      define_properties *DYNAMICS
    end

    def draw_dynamics
      DYNAMICS.each {|dynamic_element| self.send(dynamic_element).draw}
    end

    private

      def define_properties(*properties)
        properties.each do |property|
          instance_variable_set "@#{property}", to_klass(property).new(self)
        end
      end

      def to_klass(property)
        klass_name = property.to_s.split('_').map{|e| e.capitalize}.join
        Object.const_get("SpaceInvaders::#{klass_name}")
      end

  end
end