require_relative 'invader'

module SpaceInvaders
  [:A, :B, :C].each do |letter|
    clazz_name = "Invader#{letter}"
    clazz = Class.new(Invader) do
      def initialize window, x_position=0, y_position=0
        super
        @first_image = Gosu::Image.new @window, "images/#{self.class}1.png"
        @second_image = Gosu::Image.new @window, "images/#{self.class}2.png"
      end

      def points
        case self
        when InvaderA
          30
        when InvaderB
          20
        when InvaderC
          10
        end
      end
    end
    Object.const_set(clazz_name, clazz)
  end
end