module SpaceInvaders
  class GlobalTimer

    class << self
      @@start_time = nil
      @@stop_time = nil

      def start!
        @@start_time = Time.now
      end

      def stop!
        if @@stop_time.nil?
          @@stop_time = Time.now
        end
      end

      def time
        if @@stop_time
          @@stop_time - @@start_time
        else
          Time.now - @@start_time
        end
      end

      def reset!
        @@start_time = nil
        @@stop_time = nil
      end

      def draw(window)
        timer_headline(window).draw 200, 10, 1
        timer_number(window).draw 300, 10, 1
      end

      def timer_headline(window)
        @@timer_headline ||= Gosu::Image.from_text window, "Time:", Gosu.default_font_name, 30
      end

      def timer_number(window)
        Gosu::Image.from_text window, GlobalTimer.time.round(1), Gosu.default_font_name, 30
      end
    end

  end
end