describe Fastlane::Actions::DmgAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The dmg plugin is working!")

      Fastlane::Actions::DmgAction.run(nil)
    end
  end
end
