require 'space_invaders/base'
require 'space_invaders/utils'

module SpaceInvaders
  class Images < Base

    IMAGES = [ :invader_a1,
               :invader_a2,
               :invader_b1,
               :invader_b2,
               :invader_c1,
               :invader_c2,
               :red_invader,
               :ship,
               :ship_crushed_left,
               :ship_crushed_right,
               :bullet,
               :full_block,
               :ok_block,
               :weak_block
             ]

    IMAGES.each do |image|
      define_method image do
        if instance_variable_get("@#{image}").nil?
          instance_variable_set("@#{image}", Gosu::Image.new(app, asset_path(image)))
        end
        instance_variable_get("@#{image}")
      end
    end

    private

      RELATIVE_IMAGES_PATH = File.join('..', '..', '..', '..', 'assets', 'images')

      ABSOLUTE_IMAGES_PATH = File.expand_path(RELATIVE_IMAGES_PATH, __FILE__)

      def asset_path(image_name)
        camel_case_name = Utils.camelcase(image_name)
        File.join(ABSOLUTE_IMAGES_PATH, "#{camel_case_name}.png")
      end
  end
end