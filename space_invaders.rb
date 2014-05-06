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

  def bullets
    @bullet_collection
  end
end

class Bullet

  attr_reader :x_position, :y_position

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

  def out_of_screen
    if @going_up
      @y_position < 0
    else
      @y_position > @window.height
    end
  end

end

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
    offset = direction == :right ? 10 : -10
    @x_position += offset
    @current_image = @was_first_image ? @first_image : @second_image
  end

  def draw
    @current_image.draw @x_position, @y_position, 1
  end

  def points
    raise NotImplementedError.new("You must implement the inherited points method")
  end

  def width
    @current_image.width
  end

  def height
    @current_image.height
  end

  def x_middle
    @x_position + @current_image.width/2
  end

  def collides_with(bullets)
    bullets.each do |bullet|
      if bullet.x_position.between?(self.x_position, self.x_position + self.width) and bullet.y_position.between?(self.y_position, self.y_position + self.height)
        @window.score_tracker.increase_by(points)
        bullets.delete(bullet)
        return true
      end
    end
    false
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

class InvaderCollection

  attr_accessor :direction
  # attr_reader :invaders

  attr_reader :invader_clazz
  def initialize window, y_position, invader_clazz
    @window = window
    @y_position = y_position
    @invaders = []
    @direction = :right
    @invader_clazz = invader_clazz
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
    @invaders.max_by {|invader| invader.x_position }.x_position
  end

  def farmost_left_position
    @invaders.min_by {|invader| invader.x_position }.x_position
  end

  def check_collision(bullets)
    @invaders.delete_if do |invader|
       invader.collides_with bullets
    end
  end

  def count
    @invaders.count
  end

  def empty?
    @invaders.empty?
  end
end

class InvadersContainer

  attr_reader :invader_collections

  def initialize window
    @window = window

    @invaders_a = InvaderCollection.new @window, 300, InvaderA
    @invaders_b = InvaderCollection.new @window, 350, InvaderB
    @invaders_c = InvaderCollection.new @window, 400, InvaderC

    @invader_collections = []
    @invader_collections << @invaders_a
    @invader_collections << @invaders_b
    @invader_collections << @invaders_c

    @change_time = Time.now
    @direction = :right
  end

  def update(bullets)
    check_collision(bullets)
    if can_change
      if farmost_right_position >= @window.width - 80
        @direction = :left
      elsif farmost_left_position <= 20
        @direction = :right
      end
      @invader_collections.each {|invader_collection| invader_collection.update @direction }
      @change_time = Time.now
    end
  end

  def can_change
    Time.now > @change_time + 0.25
  end

  def check_collision(bullets)
    @invader_collections.each do |invader_collection|
      invader_collection.check_collision(bullets)
    end
    @invader_collections.delete_if {|invader_collection| invader_collection.empty?}
  end

  def draw
    @invader_collections.each do |invader_collection|
      invader_collection.draw
    end
  end

  def count
    count = 0
    @invader_collections.each do |invader_collection|
      count += invader_collection.count
    end
    count
  end

  def any_invaders?
    count != 0
  end

  private

    def farmost_right_position
      @invader_collections.max_by do |invader_collection|
        invader_collection.farmost_right_position
      end.farmost_right_position
    end

    def farmost_left_position
      @invader_collections.min_by do |invader_collection|
        invader_collection.farmost_left_position
      end.farmost_left_position
    end
end

class SpaceInvaders < Gosu::Window

  attr_reader :score_tracker

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Sprite Demonstration"

    @invaders_container = InvadersContainer.new self
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
    if @invaders_container.any_invaders?
      @invaders_container.update(@ship.bullets)
      @ship.update
    end
  end

  def draw
    if @invaders_container.any_invaders?
      @invaders_container.draw
    else
      congratulations.draw 100, 100, 1
    end
    @ship.draw
    @score_tracker.draw
  end

  def congratulations
    @congratulations ||= Gosu::Image.from_text self, "Congratulations!", Gosu.default_font_name, 100
  end
end

class ScoreTracker
  def initialize window
    @window = window
    @score = 0
    @score_headline = Gosu::Image.from_text @window, "Score:", Gosu.default_font_name, 30
    set_score_number
  end

  def increase_by number
    @score += number
    set_score_number
  end

  def set_score_number
    @score_number = Gosu::Image.from_text @window, @score, Gosu.default_font_name, 30
  end

  def draw
    @score_headline.draw 10, 10, 1
    @score_number.draw 100, 11, 1, 1, 1, Gosu::Color::GREEN
  end
end

SpaceInvaders.new.show