require_relative 'base'
require_relative 'utils'

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
      method_name = "#{image}_image"
      define_method method_name do
        if instance_variable_get("@#{method_name}").nil?
          instance_variable_set("@#{method_name}", Gosu::Image.new(app, asset_path(image)))
        end
        instance_variable_get("@#{method_name}")
      end
    end

    private

      def asset_path(image_name)
        camel_case_name = Utils.camelcase(image_name)
        File.join("assets", "images", "#{camel_case_name}.png")
      end
  end
end