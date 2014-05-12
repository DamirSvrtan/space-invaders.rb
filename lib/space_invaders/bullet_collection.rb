module SpaceInvaders
  class BulletCollection

    attr_reader :bullets

    def initialize
      @bullets = []
    end

    def update
      @bullets.delete_if {|bullet| bullet.out_of_screen}
      @bullets.each { |bullet| bullet.update }
    end

    def draw
      @bullets.each {|bullet| bullet.draw }
    end

    def each(&block)
      @bullets.each(&block)
    end

    def delete(bullet)
      @bullets.delete(bullet)
    end

    def <<(bullet)
      @bullets << bullet
    end

    def clear
      bullets.clear
    end

  end
end