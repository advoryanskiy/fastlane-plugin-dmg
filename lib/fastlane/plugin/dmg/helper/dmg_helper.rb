require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class DmgHelper
      def self.folder_size(folder)
        `du -ms '#{folder}'`[/^(\d+)\s+/, 1].to_i
      end
    end
  end
end
