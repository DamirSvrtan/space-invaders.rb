require_relative 'invader'

module SpaceInvaders
  class InvaderC < Invader
    def initialize app, x_position=0, y_position=0
      @first_image = app.images.invader_c1
      @second_image = app.images.invader_c2
      super
    end

    def points
      10
    end
  end
end