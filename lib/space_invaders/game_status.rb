module SpaceInvaders
  class GameStatus < Base

    attr_accessor :started, :finished, :drowned_ship

    alias_method  :started?,  :started
    alias_method  :finished?, :finished
    alias_method  :drowned_ship?, :drowned_ship

    def initialze app
      super
      @started = false
      @finished = false
      @drowned_ship = false
    end

    def being_played?
      started and not drowned_ship and not finished
    end

    def hasnt_started?
      not started?
    end

    def start!
      @started = true
    end

    def finished!
      @finished = true
    end

    def drowned_ship!
      @drowned_ship = true
    end

    def continue!
      @drowned_ship = false
    end
  end
end