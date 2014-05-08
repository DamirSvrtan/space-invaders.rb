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
        elsif app.game_status.being_played?
          app.ship.fire!
        end
      end

  end
end