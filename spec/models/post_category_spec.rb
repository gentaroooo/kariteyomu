require 'rails_helper'

RSpec.describe PostCategory, type: :model do
  describe 'バリデーション確認' do
    let(:created_post_category) { create(:post_category) }

    it '有効であること' do
      post_category = build(:post_category)
      expect(post_category).to be_valid
      expect(post_category.errors).to be_empty
    end
  end
end
