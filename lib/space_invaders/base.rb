module SpaceInvaders
  class Base
    attr_reader :app

    def initialize app
      @app = app
    end

    def game_status
      app.game_status
    end

  end
end