require 'tmpdir'

module Fastlane
  module Actions
    class DmgAction < Action
      def self.run(params)
        UI.message "Creating dmg from #{params[:path]}..."

        input_path = params[:path]

        params[:output_path] ||= input_path
        params[:volume_name] ||= File.basename(input_path, File.extname(input_path))
        # Adds 10% to the input folder size if size is not specified
        params[:size] ||= (Helper::DmgHelper.folder_size(input_path) * 1.1).to_i

        absolute_output_path = File.expand_path(params[:output_path])

        # Appends ".dmg" if path does not end in ".dmg"
        unless absolute_output_path.end_with?(".dmg")
          absolute_output_path += ".dmg"
        end

        absolute_output_dir = File.expand_path("..", absolute_output_path)
        FileUtils.mkdir_p(absolute_output_dir)

        Dir.mktmpdir('fldmg') do |dir|
          FileUtils.cp_r(input_path, dir)

          Actions.sh "hdiutil create -fs #{params[:filesystem]} -volname #{params[:volume_name]} -srcfolder #{File.expand_path(input_path).shellescape} -ov -format #{params[:format]} -size #{params[:size]}m #{absolute_output_path.shellescape}"
        end

        UI.success "Successfuly generated dmg image at path #{absolute_output_path}"
        return absolute_output_path
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
            output_path: "Latest.dmg",
            volume_name: "MyApp",
            filesystem: "HFS+",
            size: 25
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
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :volume_name,
                                       env_name: "FL_DMG_VOLUME_NAME",
                                       description: "The volume name of the resulting image",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :filesystem,
                                       env_name: "FL_DMG_FILESYSTEM",
                                       description: "The filesystem of the resulting image",
                                       default_value: "HFS+",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :format,
                                       env_name: "FL_DMG_FORMAT",
                                       description: "The format of the resulting image",
                                       default_value: "UDZO",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :size,
                                       env_name: "FL_DMG_SIZE",
                                       description: "Size of the resulting dmg file in megabytes",
                                       type: Integer,
                                       optional: true)
        ]
      end

      def self.is_supported?(platform)
        [:mac].include?(platform)
      end
    end
  end
end
