require 'rails_helper'

RSpec.describe 'Books', type: :system do
  describe 'よみたいのCRUD' do
    let(:me) { create(:user) }
    let(:book) { create(:book) }
    let(:book_by_me) { create(:book, user: me) }
    let(:author) { create(:author) }
    let(:library) { create(:library, user: me) }

    describe 'よみたいリスト' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit books_path
          expect(current_path).to eq(login_path), 'ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'よみたいが一件もない場合' do
        it '何もない旨のメッセージが表示されること' do
          login_as(me)
          visit books_path
          expect(page).to have_content('よみたいリストがまだありません'), 'よみたいが一件もない場合、「よみたいリストがありません」というメッセージが表示されていません'
        end
      end

      context 'よみたいがある場合' do
        it 'よみたいの一覧が表示されること' do
          book_by_me
          login_as(me)
          visit books_path
          expect(page).to have_content(book_by_me.title), 'よみたいリストがありません'
        end
      end
    end

    describe 'よみたいの作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit new_book_path
          expect(current_path).to eq(login_path)
          expect(page).to have_content('ログインしてください')
        end
      end

      context 'ログインしている場合' do
        before do
          login_as(me)
          library
        end
        it '検索した本を新規追加できる' do
          visit search_books_path
          fill_in 'search', with: 'はらぺこあおむし'
          click_button '検索'
          first('#new_book').click 
          expect(current_path).to eq books_path
          expect(page).to have_content 'よみたいリストに登録しました'
        end

        it '検索した本の詳細を選択すると図書館情報が表示される(はらぺこあおむし)' do
          visit search_books_path
          fill_in 'search', with: 'はらぺこあおむし'
          click_button '検索'
          first('#new_book').click
          visit book_path(1)
          sleep 5
          expect(page).to have_content '予約する'
        end

        it '検索した本の詳細を選択すると図書館情報が表示される(くまくまパン)' do
          visit search_books_path
          fill_in 'search', with: 'くまくまパン'
          click_button '検索'
          first('#new_book').click
          visit book_path(1)
          sleep 5
          expect(page).to have_content '予約する'
        end

        it '検索した本の詳細を選択すると図書館情報が表示される（図書館に本がありません）' do
          visit search_books_path
          fill_in 'search', with: '実践Rails'
          click_button '検索'
          first('#new_book').click
          visit book_path(1)
          sleep 5
          expect(page).to have_content '図書館に本がありません'
        end

        it '検索した本の詳細を選択すると図書館情報が表示されない（ISBN無し）' do
          visit search_books_path
          fill_in 'search', with: 'おおかみと7ひきのこやぎ'
          click_button '検索'
          first('#new_book').click
          visit book_path(1)
          sleep 5
          expect(page).to have_content '検索できません'
        end

        it '本の詳細が表示される' do
          create(:book_author, author: author, book: book)
          visit book_path(book)
          expect(page).to have_content book.title
        end

        it '本の削除ができる' do
          visit search_books_path
          fill_in 'search', with: 'はらぺこあおむし'
          click_button '検索'
          first('#new_book').click 
          expect(current_path).to eq books_path
          expect(page).to have_content 'よみたいリストに登録しました'
          visit book_path(1)
          sleep 5
          expect(page).to have_content '予約する'
          
          accept_alert do
            click_on 'button-delete-1'
          end  

          expect(page).to  have_content 'よみたいを削除しました'
        end
      end
    end
  end
end
