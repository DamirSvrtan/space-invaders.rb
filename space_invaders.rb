require "gosu"
require 'pry'

class Ship
  def initialize window
    @window = window
    @image = Gosu::Image.new @window, "Ship@2x.png"
    @image_x = @window.width/2 - 40
    @image_y = @window.height - 50
    @bullet_collection = BulletCollection.new
  end

  def update
    if @window.button_down? Gosu::KbLeft
      unless @image_x.between?(0, 20)
        @image_x += -5
      end
    elsif @window.button_down? Gosu::KbRight
      unless @image_x.between?(@window.width - 90, @window.width - 70)
        @image_x += 5
      end
    end
    @bullet_collection.update
  end

  def draw
    @image.draw @image_x, @image_y, 1
    @bullet_collection.draw
  end

  def x_middle
    @image_x + @image.width/2
  end

  def fire!
    bullet = Bullet.new @window, self, true
    @bullet_collection.bullets << bullet
  end
end

class Bullet
  def initialize window, ship, going_up
    @window = window
    @ship = ship
    @image = Gosu::Image.new @window, "bullet.png"
    @x_position = @ship.x_middle - @image.width/2
    @y_position = @window.height - 50
    @going_up = going_up
  end

  def update
    if @going_up
      @y_position -= 10
    else
      @y_position += 10
    end
  end

  def draw
    @image.draw @x_position, @y_position, 1
  end
end

class BulletCollection

  attr_reader :bullets

  def initialize
    @bullets = []
  end

  def update
    @bullets.each { |bullet| bullet.update }
  end

  def draw
    @bullets.each {|bullet| bullet.draw }
  end
end

class Invader

  attr_accessor :x_position, :y_position

  def initialize window, x_position=0, y_position=0
    @window = window
    @was_first_image = true
    @x_position = x_position
    @y_position = y_position
  end

  def update(direction)
    @was_first_image = !@was_first_image
    if direction == :right
      @x_position += 10
    else
      @x_position -= 10
    end
    # @current_image = @was_first_image ? @second_image : @first_image
    @current_image = @was_first_image ? @first_image : @second_image
  end

  def draw
    @current_image.draw @x_position, @y_position, 1
  end

  def x_middle
    @x_position + @current_image.width/2
  end

end

[:A, :B, :C].each do |letter|
  clazz_name = "Invader#{letter}"
  clazz = Class.new(Invader) do
    def initialize window, x_position=0, y_position=0
      super
      @first_image = Gosu::Image.new @window, "#{self.class}_00@2x.png"
      @second_image = Gosu::Image.new @window, "#{self.class}_01@2x.png"
    end
  end
  Object.const_set(clazz_name, clazz)
end

class InvaderCollection

  attr_accessor :direction
  # attr_reader :invaders

  def initialize window, y_position, invader_clazz
    @window = window
    @y_position = y_position
    @invaders = []
    @direction = :right
    [40, 110, 180, 250, 320, 390, 460, 530].each do |x_position|
      invader = invader_clazz.new(window, x_position, y_position)
      @invaders << invader
    end
  end

  def invaders
    @invaders
  end

  def update(direction)
    @invaders.each {|invader| invader.update direction }
  end

  def draw
    @invaders.each {|invader| invader.draw }
  end

  def each(&block)
    @invaders.each(&block)
  end

  def farmost_right_position
    @invaders.max {|invader| invader.x_position }.x_position
  end

  def farmost_left_position
    @invaders.min {|invader| invader.x_position }.x_position
  end
end

class InvadersContainer

  attr_reader :invader_collections

  def initialize window
    @window = window
    @invader_collections = []
    @change_time = Time.now
    @direction = :right
  end

  def update
    if can_change
      if farmost_right_position >= @window.width - 90
        @direction = :left
      elsif farmost_left_position <= 20
        @direction = :right
      end
      @invader_collections.each {|invader_collection| invader_collection.update @direction }
      @change_time = Time.now
    end
  end

  def can_change
    Time.now > @change_time + 0.4
  end

  def draw
    @invader_collections.each do |invader_collection|
      invader_collection.draw
    end
  end

  def farmost_right_position
    @invader_collections.max do |invader_collection|
      invader_collection.farmost_right_position
    end.farmost_right_position
  end

  def farmost_left_position
    @invader_collections.min do |invader_collection|
      invader_collection.farmost_left_position
    end.farmost_left_position
  end

end

class SpaceInvaders < Gosu::Window

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Sprite Demonstration"

    @invaders_a = InvaderCollection.new self, 300, InvaderA
    @invaders_b = InvaderCollection.new self, 350, InvaderB
    @invaders_c = InvaderCollection.new self, 400, InvaderC
    @invaders_container = InvadersContainer.new self
    @invaders_container.invader_collections << @invaders_a
    @invaders_container.invader_collections << @invaders_b
    @invaders_container.invader_collections << @invaders_c

    @ship = Ship.new self

    @score_tracker = ScoreTracker.new self
  end

  def button_down id
    if id == Gosu::KbEscape
      close 
    elsif id == Gosu::KbSpace
      @ship.fire!
    end
  end

  def update
    @invaders_container.update
    @ship.update
    @score_tracker.update
  end

  def draw
    @invaders_container.draw
    @ship.draw
    @score_tracker.draw
  end

end

class ScoreTracker
  def initialize window
    @window = window
    @score = 0
    @image = Gosu::Image.from_text window, "Score: #{@score}", Gosu.default_font_name, 30
  end

  def increase_by number
    @score += number
  end

  def update
  end

  def draw
    @image.draw 10, 10, 1
  end
end

SpaceInvaders.new.show