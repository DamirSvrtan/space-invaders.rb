require "gosu"
require 'pry'

class Ship
  def initialize window
    @window = window
    @image = Gosu::Image.new @window, "Ship@2x.png"
    @image_x = @window.width/2 - 40
    @image_y = @window.height - 50
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
  end

  def draw
    @image.draw @image_x, @image_y, 1
  end

  def x_middle
    @image_x + @image.width/2
  end
end

class Bullet
  def initialize window, ship
    @window = window
    @ship = ship
    @image = Gosu::Image.new @window, "bullet.png"
    @x_position = @ship.x_middle - @image.width/2
    @y_position = @window.height - 50
  end

  def update
    @y_position -= 10
  end

  def draw
    @image.draw @x_position, @y_position, 1
  end
end

class Sprite
  def initialize window
    @window = window
    # image
    @width = @height = 160
    # @idle = Gosu::Image.load_tiles @window,
    #                                "player_160x160_idle.png",
    #                                @width, @height, true
    # @move = Gosu::Image.load_tiles @window,
    #                                "player_160x160_move.png",
    #                                @width, @height, true
    @invader_a = Gosu::Image.new @window, "InvaderA_00@2x.png"
    @invader_b = Gosu::Image.new @window, "InvaderB_00@2x.png"
    @invader_c = Gosu::Image.new @window, "InvaderC_00@2x.png"
    # @ship = Gosu::Image.new @window, "Ship@2x.png"
    # @ship_x = window.width/2 - 40
    # center image
    @x = @window.width/2  - @width/2
    @y = @window.height/2 - @height/2
    # direction and movement
    @direction = :right
    @frame = 3
    @moving = false
  end

  def update

  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    @invader_a.draw 0, 0, 1
    @invader_b.draw 60, 0, 1
    @invader_c.draw 120, 0, 1

    # @ship.draw @ship_x, @window.height - 50, 1
    # f = @frame % @idle.size
    # image = @space_invaders[f]
    # if @direction == :right
    #   image.draw @x, @y, 1
    # else
    #   image.draw @x + @width, @y, 1, -1, 1
    # end
  end

end

class Invader
  def initialize window, x_position=0, y_position=0
    @window = window
    @was_first_image = true
    @change_time = Time.now
    @x_position = x_position
    @y_position = y_position
  end

  def update
    if can_change
      @current_image = @was_first_image ? @second_image : @first_image
      @change_time = Time.now
      @was_first_image = !@was_first_image
      @x_position += 10
    else
      @current_image = @was_first_image ? @first_image : @second_image
    end
  end

  def can_change
    Time.now > @change_time + 0.5
  end

  def draw
    @current_image.draw @x_position, @y_position, 1
  end

  def x_middle
    @x_position + @current_image.width/2
  end

end

# class InvaderA < Invader
#   def initialize window, x_position=0, y_position=0
#     super
#     @first_image = Gosu::Image.new @window, "InvaderA_00@2x.png"
#     @second_image = Gosu::Image.new @window, "InvaderA_01@2x.png"
#   end
# end

# class InvaderB < Invader
#   def initialize window, x_position=0, y_position=0
#     super
#     @first_image = Gosu::Image.new @window, "InvaderB_00@2x.png"
#     @second_image = Gosu::Image.new @window, "InvaderB_01@2x.png"
#   end
# end

# class InvaderC < Invader
#   def initialize window, x_position=0, y_position=0
#     super
#     @first_image = Gosu::Image.new @window, "InvaderC_00@2x.png"
#     @second_image = Gosu::Image.new @window, "InvaderC_01@2x.png"
#   end
# end

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

class BulletCollection
  @@bullets = []
  def self.bullets
    @@bullets
  end

  def self.update

  end
  def self.draw

  end
end

class InvaderCollection

  def initialize window, y_position, invader_id
    @window = window
    @y_position = y_position
    @invaders = []
    invader_constant = Object.const_get("Invader#{invader_id}")
    [40, 110, 180, 250, 320, 390, 460, 530].each do |x_position|
      invader = invader_constant.new(window, x_position, y_position)
      @invaders << invader
    end
  end

  def invaders
    @invaders
  end

  def update
    @invaders.each {|invader| invader.update }
  end

  def draw
    @invaders.each {|invader| invader.draw }
  end

  def each(&block)
    @invaders.each(&block)
  end

end
class SpaceInvaders < Gosu::Window

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "Sprite Demonstration"
    # @invader_a = InvaderA.new self, 110, 0
    # @invader_b = InvaderB.new self, 180, 0
    # @invader_c = InvaderC.new self, 250, 0
    @invaders_a = InvaderCollection.new self, 300, "A"
    @invaders_b = InvaderCollection.new self, 350, "B"
    @invaders_c = InvaderCollection.new self, 400, "C"
    @ship = Ship.new self
  end

  def button_down id
    if id == Gosu::KbEscape
      close 
    elsif id == Gosu::KbSpace
      bullet = Bullet.new self, @ship
      BulletCollection.bullets << bullet
    end
  end

  def update
    # @invader_a.update
    # @invader_b.update
    # @invader_c.update
    @invaders_a.update
    @invaders_b.update
    @invaders_c.update

    @ship.update
    BulletCollection.bullets.each do |bullet|
      bullet.update
    end
  end

  def draw
    # @invader_a.draw
    # @invader_b.draw
    # @invader_c.draw
    @invaders_a.draw
    @invaders_b.draw
    @invaders_c.draw
    @ship.draw
    BulletCollection.bullets.each do |bullet|
      bullet.draw
    end
  end

end

SpaceInvaders.new.show