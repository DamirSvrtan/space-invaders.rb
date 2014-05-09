require_relative 'abstract_vehicle'

module SpaceInvaders
  class Invader < AbstractVehicle
    attr_reader :original_x_position

    def initialize app, x_position, y_position
      super app

      @was_first_image = true
      @x_position = x_position
      @original_x_position = x_position
      @y_position = y_position
    end

    def update(direction, y_offset=0)
      offset = direction == :right ? 10 : -10
      @x_position += offset
      @y_position += y_offset

      @was_first_image = !@was_first_image
      @image = @was_first_image ? @first_image : @second_image
    end

    def points
      raise NotImplementedError.new("You must implement the inherited points method")
    end

  end
end