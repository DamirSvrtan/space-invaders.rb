require_relative 'base'

module SpaceInvaders
  class ButtonController < Base

    def button_down id
      case id
      when Gosu::KbEscape
        app.close
      when Gosu::KbSpace
        if app.game_status.hasnt_started?
          app.game_status.start!
        elsif app.game_status.being_played?
          app.ship.fire!
        end
      end

    end
  end
end