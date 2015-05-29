require 'rails_helper'

RSpec.describe Identifier, type: :model do
  let(:identifier) { create :identifier }

  describe 'the code' do
    it 'should be unique' do
      iden2 = Identifier.new(code: identifier.code)
      expect(iden2.valid?).to be_falsey
    end
  end
end
