require 'forwardable'

module SpaceInvaders
  class BulletCollection
    extend Forwardable
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

    def_delegators :@bullets, :each, :delete, :<<, :clear
  end
end