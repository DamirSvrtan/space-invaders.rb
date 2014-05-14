module SpaceInvaders
  module Mesurable
    attr_accessor :x_position, :y_position

    def x_middle
      @x_position + @image.width/2
    end

    def width
      @image.width
    end

    def height
      @image.height
    end
  end
end