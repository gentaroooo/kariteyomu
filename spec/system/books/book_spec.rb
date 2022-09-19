# require 'rails_helper'

# RSpec.describe 'Books', type: :system do
#   describe '本のCRUD' do
#     let(:me) { create(:user) }
#     let(:book) { create(:book) }
#     let(:book_by_me) { create(:book, user: me) }
#     let(:author) { create(:author) }
#     before { login_as(me) }

#     context '正常系' do
#       it '検索した本を新規追加できる' do
#         visit search_books_path
#         fill_in 'search', with: 'apple'
#         click_button '検索'
#         first('.card-link').click
#         expect(current_path).to eq new_book_path
#         fill_in 'レビュー', with: 'レビュー内容'
#         select 'プログラミング', from: 'parent_category'
#         select 'Ruby', from: 'child_category'
#         expect{ click_button '登録する' }.to change{ Book.count }.by(1)
#         expect(current_path).to eq books_path
#         expect(page).to have_content 'レビューを作成しました'
#       end

#       it '本の一覧が表示される' do
#         book_1 = create(:book)
#         book_2 = create(:book)
#         visit books_path
#         expect(page).to have_content book_1.title
#         expect(page).to have_content book_2.title
#       end

#       it '本の詳細が表示される' do
#         create(:book_author, author: author, book: book)
#         visit book_path(book)
#         expect(page).to have_content book.title
#         expect(page).to have_content book.body
#         expect(page).to have_content book.category.name
#         expect(page).to have_content book.user.name
#         expect(page).to have_content book.published_date
#         expect(page).to have_content author.name
#         expect(page).to have_link '詳細を見る', href: book.info_link
#       end

#       it '本の編集ができる' do
#         visit edit_book_path(book_by_me)
#         fill_in 'レビュー', with: 'レビュー編集'
#         click_button '更新する'
#         expect(current_path).to eq book_path(book_by_me)
#         expect(page).to have_content 'レビューを更新しました'
#         expect(page).to have_content 'レビュー編集'
#       end

#       it '本の削除ができる' do
#         visit book_path(book_by_me)
#         title = book_by_me.title
#         find('.card .dropdown').click
#         expect{
#           click_link '削除' 
#           page.accept_confirm
#           expect(page).to have_content 'レビューを削除しました'
#         }.to change{ Book.count }.by(-1)
#         expect(current_path).to eq books_path
#         expect(page).not_to have_content title
#       end

#       it '自分が追加した本には歯車アイコンが表示される' do
#         visit book_path(book_by_me)
#         expect(page).to have_css '.card .dropdown'
#       end

#       it '他人が追加した本には歯車アイコンが表示されない' do
#         visit book_path(book)
#         expect(page).not_to have_css '.card .dropdown' 
#       end
#     end

#     context '異常系' do
#       it '検索キーワードがない場合検索されない' do
#         visit search_books_path
#         fill_in 'search', with: ''
#         click_button '検索'
#         expect(page).to have_content '検索キーワードが入力されていません'
#         expect(page).not_to have_css '.card-link'
#       end

#       it '入力が不足している場合、検索した本を新規追加できない' do
#         visit search_books_path
#         fill_in 'search', with: 'apple'
#         click_button '検索'
#         first('.card-link').click
#         expect(current_path).to eq new_book_path
#         fill_in 'レビュー', with: ''
#         select 'プログラミング', from: 'parent_category'
#         select 'Ruby', from: 'child_category'
#         expect{ click_button '登録する' }.to change{ Book.count }.by(0)
#         expect(current_path).to eq books_path
#         expect(page).to have_content 'レビューを作成できませんでした'
#         expect(page).to have_content 'レビューは5文字以上で入力してください'
#       end

#       it '入力が不足している場合、本の編集ができない' do
#         visit edit_book_path(book_by_me)
#         fill_in 'レビュー', with: ''
#         click_button '更新する'
#         expect(current_path).to eq book_path(book_by_me)
#         expect(page).to have_content 'レビューを更新できませんでした'
#         expect(page).to have_content 'レビューは5文字以上で入力してください'
#       end
#     end
#   end
# end
