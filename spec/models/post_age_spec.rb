require 'rails_helper'

RSpec.describe PostAge, type: :model do
  describe 'バリデーション確認' do
    let(:created_post_age) { create(:post_age) }

    it '有効であること' do
      post_age = build(:post_age)
      expect(post_age).to be_valid
      expect(post_age.errors).to be_empty
    end
  end
end
