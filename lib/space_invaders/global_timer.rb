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
    end

  end
end