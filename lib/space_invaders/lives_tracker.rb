module SpaceInvaders
  class LivesTracker < Base

    attr_reader :lives

    def initialize application
      @application = application
      @lives = application.ship.lives
      @lives_headline = Gosu::Image.from_text @application, "Lives:", app.default_font, 30
      set_lives_number
    end

    def decrease_lives!
      @lives -= 1
      set_lives_number
    end

    def set_lives_number
      @lives_number = Gosu::Image.from_text @application, @lives, app.default_font, 30
    end

    def draw
      @lives_headline.draw app.width - 150, 10, 1
      @lives_number.draw app.width - 50, 10, 1, 1, 1, Gosu::Color::GREEN
    end
  end
end