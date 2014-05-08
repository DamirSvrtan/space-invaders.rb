require_relative 'invader'

module SpaceInvaders
  class InvaderA < Invader
    def initialize app, x_position=0, y_position=0
      super
      @first_image = app.invader_a1_image
      @second_image = app.invader_a2_image
    end

    def points
      40
    end
  end
end