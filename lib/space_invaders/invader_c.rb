require_relative 'invader'

module SpaceInvaders
  class InvaderC < Invader
    def initialize app, x_position=0, y_position=0
      super
      @first_image = app.invader_c1_image
      @second_image = app.invader_c2_image
    end

    def points
      10
    end
  end
end