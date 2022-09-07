require 'rails_helper'

RSpec.describe '掲示板', type: :system do
  let(:user) { create(:user) }
  let(:book) { create(:book, user: user) }

  describe '掲示板のCRUD' do
    describe '掲示板の一覧' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit books_path
          expect(current_path).to eq(login_path), 'ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it 'ヘッダーのリンクから掲示板一覧へ遷移できること' do
          login_as_general
          click_on('掲示板')
          click_on('掲示板一覧')
          expect(current_path).to eq(books_path), 'ヘッダーのリンクから掲示板一覧画面へ遷移できません'
        end

        context '掲示板が一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login_as_general
            visit books_path
            expect(page).to have_content('掲示板がありません'), '掲示板が一件もない場合、「掲示板がありません」というメッセージが表示されていません'
          end
        end

        context '掲示板がある場合' do
          it '掲示板の一覧が表示されること' do
            book
            login_as_general
            visit books_path
            expect(page).to have_content(book.title), '掲示板一覧画面に掲示板のタイトルが表示されていません'
            expect(page).to have_content(book.user.decorate.full_name), '掲示板一覧画面に投稿者のフルネームが表示されていません'
            expect(page).to have_content(book.body), '掲示板一覧画面に掲示板の本文が表示されていません'
          end
        end
      end
    end
  end
end