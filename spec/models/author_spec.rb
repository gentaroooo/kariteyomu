require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'バリデーション確認' do
    let(:created_author) { create(:author) }

    it '有効であること' do
      author = build(:author)
      expect(author).to be_valid
      expect(author.errors).to be_empty
    end

    it '名前がない場合、無効' do
      author = build(:author, name: nil)
      expect(author).to be_invalid
      expect(author.errors[:name]).to eq ["を入力してください"]
    end

    it '重複した名前の場合、無効' do
      author = build(:author, name: created_author.name)
      expect(author).to be_invalid
      expect(author.errors[:name]).to eq ["はすでに存在します"]
    end
  end
end
