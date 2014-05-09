require_relative 'invader'

module SpaceInvaders
  class InvaderC < Invader
    def initialize app, x_position=0, y_position=0
      @first_image = app.invader_c1_image
      @second_image = app.invader_c2_image
      super
    end

    def points
      10
    end
  end
end