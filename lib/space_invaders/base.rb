module SpaceInvaders
  class Base
    attr_reader :application

    alias_method :app, :application

    def initialize application
      @application = application
    end

    def horizontal_center_draw(image, y, z = 1, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
      x = app.width/2 - image.width/2
      image.draw(x, y, z, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
    end
  end
end