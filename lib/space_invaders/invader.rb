require_relative 'abstract_vehicle'

module SpaceInvaders
  class Invader < AbstractVehicle
    attr_reader :original_x_position

    def initialize application, x_position, y_position
      super(application)
      
      @was_first_image = true
      @x_position = x_position
      @original_x_position = x_position
      @y_position = y_position
    end

    def update(direction)
      @was_first_image = !@was_first_image
      offset = direction == :right ? 10 : -10
      @x_position += offset
      @image = @was_first_image ? @first_image : @second_image
      @bullet_collection.update
    end

    def points
      raise NotImplementedError.new("You must implement the inherited points method")
    end

  end
end