module Fastlane
  module Helper
    class DmgHelper
      def self.folder_size(folder)
        `du -ms '#{source_path}'`[/^(\d+)\s+/, 1].to_i
      end
    end
  end
end
