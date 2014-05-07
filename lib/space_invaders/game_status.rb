module SpaceInvaders
  class GameStatus < Base

    attr_accessor :started, :finished

    alias_method  :started?,  :started
    alias_method  :finished?, :finished

    def initialze application
      super
      @started = false
      @finished = false
    end

    def being_played?
      started and !finished
    end

    def hasnt_started?
      !started?
    end

    def start!
      @started = true
    end

    def finished!
      @finished = true
    end

  end
end