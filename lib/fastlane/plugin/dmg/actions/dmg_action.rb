module Fastlane
  module Actions
    class DmgAction < Action
      def self.run(params)
        UI.message("The dmg plugin is working!")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Create DMG for your Mac app"
      end

      def self.authors
        ["Alexey Dvoryanskiy"]
      end

      def self.category
        :misc
      end

      def self.output
        []
      end

      def self.return_value
        "The path of the output dmg file"
      end

      def self.details
        "Use this action to create dmg for Mac app"
      end

      def self.example_code
        [
          'dmg',
          'dmg(
            path: "MyApp.app",
            output_path: "Latest.dmg"
          )'
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_DMG_PATH",
                                       description: "Path to the directory to be archived to dmg",
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find folder at path '#{File.expand_path(value)}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :output_path,
                                       env_name: "FL_DMG_OUTPUT_PATH",
                                       description: "The name of the resulting dmg file",
                                       optional: true)
        ]
      end

      def self.is_supported?(platform)
        [:mac].include?(platform)
      end
    end
  end
end
