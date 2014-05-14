module SpaceInvaders
  class GameStatus < Base

    attr_accessor :started, :finished, :drowned_ship, :next_level

    alias_method  :started?,  :started
    alias_method  :finished?, :finished
    alias_method  :drowned_ship?, :drowned_ship
    alias_method  :next_level?, :next_level

    def initialze app
      super
      @started = false
      @finished = false
      @drowned_ship = false
      @next_level = false
    end

    def being_played?
      started? && !drowned_ship && !next_level? && !finished?
    end

    def hasnt_started?
      not started?
    end

    def next_level!
      @next_level = true
    end

    def start!
      @started = true
      @finished = false
    end

    def finished!
      @finished = true
    end

    def drowned_ship!
      @drowned_ship = true
    end

    def continue!
      @drowned_ship = false
      @next_level = false
    end

    def status
    end
  end
end