require 'space_invaders/base'
require 'space_invaders/block'

module SpaceInvaders
  class UBlock < Base

    attr_reader :blocks, :x_position, :y_position

    def initialize app, x_position, y_position
      super app
      @x_position = x_position
      @y_position = y_position
      @blocks = []
      initialize_blocks
    end

    def update
      blocks.each {|block| block.update }
    end

    def draw
      blocks.each {|block| block.draw }
    end

    def initialize_blocks
      x = [10, 10, 10, 40, 70, 70, 70]
      y = [10, 30, 50, 10, 10, 30, 50]
      7.times do |i|
        @blocks << Block.new(self, x[i] + x_position, y[i] + y_position)
      end
    end

    def delete(block)
      blocks.delete(block)
    end
  end
end