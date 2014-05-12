require_relative 'base'
require_relative 'collideable'

module SpaceInvaders
  class Block < Base
    include Collideable

    attr_accessor :health, :x_position, :y_position, :u_block

    def initialize u_block, x_position, y_position
      super(u_block.app)

      @u_block = u_block
      @x_position = x_position
      @y_position = y_position
      @health = 3
      set_image
    end

    def update
      downgrade_image_or_die if collides_with? rival_bullets
    end

    def draw
      @image.draw x_position, y_position, 1
    end

    def rival_bullets
      app.ship.bullets.bullets + app.invaders_container.bullets.bullets
    end

    def width
      @image.width
    end

    def height
      @image.height
    end

    def dead?
      health.zero?
    end

    def downgrade_image_or_die
      self.health -= 1
      if health > 0
        set_image 
      else
        u_block.delete(self)
      end
    end

    def set_image
      @image = case health
               when 3 then app.images.full_block_image
               when 2 then app.images.ok_block_image
               when 1 then app.images.weak_block_image
               end
    end

  end
end