describe Fastlane::Actions::DmgAction do
  before do
    allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
    @path = "./spec/fixtures/app/app"
    @output_path_with_dmg = "./spec/fixtures/app/img.dmg"
    @output_path_without_dmg = "./spec/fixtures/app/img"
  end

  describe "dmg" do
    it "generates a valid hdiutil command" do
      # Actions.sh "hdiutil create \
      #    -fs #{params[:filesystem]} \
      #    -volname #{params[:volume_name]} \
      #    -srcfolder #{absolute_output_path.shellescape} \
      #    -ov \
      #    -format #{params[:format]} \
      #    -size #{params[:size]}m #{absolute_output_path.shellescape}"
      expect(Actions).to receive(:sh).with("hdiutil create -fs HFS+ -volname MyApp -srcfolder #{File.expand_path(@path).shellescape} -ov -format UDZO -size 1m #{(File.expand_path(@path) + '.dmg').shellescape}")

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}')
      end").runner.execute(:test)
    end
  end
end
