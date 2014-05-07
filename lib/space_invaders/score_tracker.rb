module SpaceInvaders
  class ScoreTracker < Base

    def initialize application
      @application = application
      @score = 0
      @score_headline = Gosu::Image.from_text @application, "Score:", Gosu.default_font_name, 30
      set_score_number
    end

    def increase_by number
      @score += number
      set_score_number
    end

    def set_score_number
      @score_number = Gosu::Image.from_text @application, @score, Gosu.default_font_name, 30
    end

    def draw
      @score_headline.draw 10, 10, 1
      @score_number.draw 100, 11, 1, 1, 1, Gosu::Color::GREEN
    end
  end
end