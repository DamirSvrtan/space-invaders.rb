require_relative 'base'

module SpaceInvaders
  class ButtonController < Base

    def button_down id
      app.close if id == Gosu::KbEscape

      if app.game_status.hasnt_started?
        app.game_status.start! if id == Gosu::KbSpace
      elsif app.game_status.being_played?
        app.ship.fire! if id == Gosu::KbSpace
      end

    end
  end
end