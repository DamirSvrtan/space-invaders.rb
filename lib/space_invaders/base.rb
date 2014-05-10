module SpaceInvaders
  class Base
    attr_reader :app

    def initialize app
      @app = app
    end

    def game_status
      app.game_status
    end

    def horizontal_center_draw(image, y)
      x = app.width/2 - image.width/2
      image.draw(x, y, 1)
    end

  end
end