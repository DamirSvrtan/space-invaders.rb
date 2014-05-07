require_relative 'invader'

module SpaceInvaders
  class InvaderA < Invader
    def initialize window, x_position=0, y_position=0
      super
      @first_image = window.invader_a1_image
      @second_image = window.invader_a2_image
    end

    def points
      30
    end
  end
end