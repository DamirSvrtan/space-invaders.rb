require_relative 'invader'

module SpaceInvaders
  class InvaderB < Invader
    def initialize application, x_position=0, y_position=0
      super
      @first_image = application.invader_b1_image
      @second_image = application.invader_b2_image
    end

    def points
      20
    end
  end
end