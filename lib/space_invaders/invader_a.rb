require_relative 'invader'

module SpaceInvaders
  class InvaderA < Invader
    def initialize application, x_position=0, y_position=0
      super
      @first_image = application.invader_a1_image
      @second_image = application.invader_a2_image
    end

    def points
      40
    end
  end
end