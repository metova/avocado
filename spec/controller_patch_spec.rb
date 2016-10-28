RSpec.describe Avocado::ControllerPatch do
  describe '.apply' do
    it 'adds itself to the ActionController::Base ancestor chain' do
      described_class.apply
      expect(ActionController::Base.ancestors).to include described_class
    end
  end
end
