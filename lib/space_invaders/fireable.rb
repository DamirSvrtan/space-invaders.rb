require_relative 'bullet_collection'
require_relative 'bullet'

module SpaceInvaders
  module Fireable

    def bullet_collection
      @bullet_collection ||= BulletCollection.new
    end

    alias_method :bullets, :bullet_collection

    def fire!
      bullet = Bullet.new(shooter, bullets_going_down?, bullet_collection, bullet_offset_speed)
      sound.play
    end

    def shooter
      raise NotImplementedError.new("You must implement the inherited shooter method")
    end

    def sound
      raise NotImplementedError.new("You must implement the inherited sound method")
    end

    def bullets_going_down?
      true
    end

    def bullet_offset_speed
      5
    end

  end
end