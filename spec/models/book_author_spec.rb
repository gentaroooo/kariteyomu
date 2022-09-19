require 'rails_helper'

RSpec.describe BookAuthor, type: :model do
  describe 'バリデーション確認' do
    let(:created_book_author) { create(:book_author) }

    it '有効であること' do
      book_author = build(:book_author)
      expect(book_author).to be_valid
      expect(book_author.errors).to be_empty
    end

    it '重複している組み合わせの場合、無効' do
      book_author = build(:book_author, book: created_book_author.book, author: created_book_author.author)
      expect(book_author).to be_invalid
      expect(book_author.errors[:book_id]).to eq ["はすでに存在します"]
    end
  end
end
