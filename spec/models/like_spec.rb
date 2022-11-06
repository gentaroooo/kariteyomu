require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーション確認' do
    let(:created_like) { create(:like) }

    it '有効であること' do
      like = build(:like)
      expect(like).to be_valid
      expect(like.errors).to be_empty
    end
  end
end
