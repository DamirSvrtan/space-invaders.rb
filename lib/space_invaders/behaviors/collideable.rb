module SpaceInvaders
  module Collideable
    def collides_with?(bullets)
      bullets.each do |bullet|
        if got_hit_by? bullet
          bullet.delete
          return true
        end
      end
      return false
    end

    def got_hit_by?(bullet)
      bullet.x_position.between?(x_position, x_position + width) and
      bullet.y_position.between?(y_position, y_position + height)
    end
  end
end