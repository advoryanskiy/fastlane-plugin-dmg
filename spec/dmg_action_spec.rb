describe Fastlane::Actions::DmgAction do
  before do
    allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
    @path = "./spec/fixtures/app/app"
    @tmp_path = "#{Dir.tmpdir}/fldmg"
    @output_path_with_dmg = "./spec/fixtures/app/img2.dmg"
    @output_path_without_dmg = "./spec/fixtures/app/img"
  end

  describe "dmg" do
    it "generates a valid hdiutil command (with default values)" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs HFS+ -volname app -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDZO -size 1m #{"#{File.expand_path(@path)}.dmg".shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}')
      end").runner.execute(:test)
    end

    it "generates a valid hdiutil command given output path without extension" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs HFS+ -volname app -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDZO -size 1m #{"#{File.expand_path(@output_path_without_dmg)}.dmg".shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', output_path: '#{@output_path_without_dmg}')
      end").runner.execute(:test)
    end

    it "generates a valid hdiutil command given dmg extension" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs HFS+ -volname app -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDZO -size 1m #{File.expand_path(@output_path_with_dmg).shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', output_path: '#{@output_path_with_dmg}')
      end").runner.execute(:test)
    end

    it "generates a valid hdiutil command given filesystem" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs FAT32 -volname app -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDZO -size 1m #{"#{File.expand_path(@path)}.dmg".shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', filesystem: 'FAT32')
      end").runner.execute(:test)
    end

    it "generates a valid hdiutil command given volume name" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs HFS+ -volname MyApp -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDZO -size 1m #{"#{File.expand_path(@path)}.dmg".shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', volume_name: 'MyApp')
      end").runner.execute(:test)
    end

    it "generates a valid hdiutil command given format" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs HFS+ -volname app -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDRW -size 1m #{"#{File.expand_path(@path)}.dmg".shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', format: 'UDRW')
      end").runner.execute(:test)
    end

    it "generates a valid hdiutil command given size" do
      expect(Fastlane::Actions).to receive(:sh) do |cmd|
        expect(cmd).to start_with("hdiutil create -fs HFS+ -volname app -srcfolder #{File.expand_path(@tmp_path).shellescape}")
        expect(cmd).to end_with(" -ov -format UDZO -size 5m #{"#{File.expand_path(@path)}.dmg".shellescape}")
      end

      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', size: 5)
      end").runner.execute(:test)
    end

    it "generates an output dmg path given output path without extension" do
      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', output_path: '#{@output_path_without_dmg}')
      end").runner.execute(:test)

      expect(result).to eq(File.absolute_path("#{@output_path_without_dmg}.dmg"))
    end

    it "generates an output dmg path given output path with extension" do
      result = Fastlane::FastFile.new.parse("lane :test do
        dmg(path: '#{@path}', output_path: '#{@output_path_with_dmg}')
      end").runner.execute(:test)

      expect(result).to eq(File.absolute_path(@output_path_with_dmg))
    end
  end
end
