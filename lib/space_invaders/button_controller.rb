require_relative 'base'

module SpaceInvaders
  class ButtonController < Base

    def button_down id
      case id
      when Gosu::KbEscape
        escape
      when Gosu::KbSpace
        space
      end
    end

    private

      def escape
        app.close
      end

      def space
        if game_status.hasnt_started?
          game_status.start!
        elsif game_status.being_played?
          app.ship.fire!
        elsif game_status.finished?
          app.initialize_dynamics
          game_status.start!
        end
      end

  end
end