module SpaceInvaders
  module Centerable
    def horizontal_center_draw(image, y)
      x = app.width/2 - image.width/2
      image.draw(x, y, 1)
    end

    def vertical_center_draw(image, x)
      y = app.height/2 - image.height/2
      image.draw(x, y, 1)
    end
  end
end