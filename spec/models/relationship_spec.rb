require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'バリデーション確認' do
    let(:created_relationship) { create(:relationship) }

    it '有効であること' do
      relationship = build(:relationship)
      expect(relationship).to be_valid
      expect(relationship.errors).to be_empty
    end
  end
end
