module Fastlane
  module Helper
    class DmgHelper
      # class methods that you define here become available in your action
      # as `Helper::DmgHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the dmg plugin helper!")
      end
    end
  end
end
