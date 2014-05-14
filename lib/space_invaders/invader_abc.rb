require 'space_invaders/invader'
require 'space_invaders/utils'

module SpaceInvaders
  [:invader_a, :invader_b, :invader_c].each do |invader_name|
    clazz_name = Utils.camelcase(invader_name)
    clazz = Class.new(Invader) do
      def initialize app, x_position=0, y_position=0
        @first_image = Gosu::Image.new app, app.images.send("#{Utils.snake_klazz_name(self.class)}1")
        @second_image = Gosu::Image.new app, app.images.send("#{Utils.snake_klazz_name(self.class)}2")
        super
      end

      def points
        case self
        when InvaderA
          40
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