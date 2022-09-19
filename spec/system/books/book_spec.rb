require 'rails_helper'

RSpec.describe 'Books', type: :system do
  describe '読みたいのCRUD' do
    let(:me) { create(:user) }
    let(:book) { create(:book) }
    let(:book_by_me) { create(:book, user: me) }
    let(:author) { create(:author) }

      describe '読みたいリスト' do
        context 'ログインしていない場合' do
          it 'ログインページにリダイレクトされること' do
            visit books_path
            expect(current_path).to eq(login_path), 'ログインページにリダイレクトされていません'
            expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
          end
        end

        context 'ログインしている場合' do
          it 'ヘッダーのリンクから読みたい一覧へ遷移できること' do
            login_as(me)
            click_on('読みたいリスト')
            expect(current_path).to eq(books_path), 'ヘッダーのリンクから読みたい一覧画面へ遷移できません'
          end
        end

        context '読みたいが一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login_as(me)
            visit books_path
            expect(page).to have_content('読みたいリストがありません'), '読みたいが一件もない場合、「読みたいリストがありません」というメッセージが表示されていません'
          end
        end

        context '読みたいがある場合' do
          it '読みたいの一覧が表示されること' do
            book_by_me
            login_as(me)
            visit books_path
            expect(page).to have_content(book_by_me.title), '読みたいリストがありません'
          end
        end
      end

    describe '読みたいの作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit new_book_path
          expect(current_path).to eq(login_path)
          expect(page).to have_content('ログインしてください')
        end
      end

      context 'ログインしている場合' do
        before { login_as(me) }
        it '検索した本を新規追加できる' do
          visit search_books_path
          fill_in 'search', with: 'はらぺこあおむし'
          click_button '検索'
          first('#new_book').click 
          expect(current_path).to eq books_path
          expect(page).to have_content '読みたいに登録しました'
        end

        it '本の詳細が表示される' do
          create(:book_author, author: author, book: book)
          visit book_path(book)
          expect(page).to have_content book.title
          expect(page).to have_content book.user.name
          expect(page).to have_content book.published_date
          expect(page).to have_content author.name
          expect(page).to have_link '詳細を見る', href: book.info_link
        end

        # it '本の削除ができる' do
        #   visit book_path(book_by_me)
        #   title = book_by_me.title
        #   binding.pry
        #   find('#button-delete-#{book.id}').click
        #   link = find('#settings-link')
        #   link = find('.settings-link')
        #   expect{
        #     click_link '削除' 
        #     page.accept_confirm
        #     expect(page).to have_content '読みたいを削除しました'
        #   }.to change{ book.count }.by(-1)
        #   expect(current_path).to eq books_path
        #   expect(page).not_to have_content title
        # end

        # it '自分が追加した本には編集アイコンが表示される' do
        #   visit book_path(book_by_me)
        #   expect(page).to have_css '.fa-trash:before'
        # end

        # it '他人が追加した本には歯車アイコンが表示されない' do
        #   visit book_path(book)
        #   expect(page).not_to have_css '.fa-trash:before' 
        # end
      end

      context '異常系' do
        before { login_as(me) }
      end
    end
  end
end
