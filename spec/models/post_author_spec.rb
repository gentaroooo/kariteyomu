require 'rails_helper'

RSpec.describe PostAuthor, type: :model do
  describe 'バリデーション確認' do
    let(:created_post_author) { create(:post_author) }

    it '有効であること' do
      post_author = build(:post_author)
      expect(post_author).to be_valid
      expect(post_author.errors).to be_empty
    end

    it '重複している組み合わせの場合、無効' do
      post_author = build(:post_author, post: created_post_author.post, author: created_post_author.author)
      expect(post_author).to be_invalid
      expect(post_author.errors[:post_id]).to eq ["はすでに存在します"]
    end
  end
end
