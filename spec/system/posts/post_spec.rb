require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'レビューのCRUD' do
    let(:me) { create(:user) }
    let(:post) { create(:post) }
    let(:post_by_me) { create(:post, user: me) }
    let(:author) { create(:author) }

      describe 'レビューリスト' do
        # context 'ログインしていない場合' do
        #   it 'ログインページにリダイレクトされること' do
        #     visit books_path
        #     expect(current_path).to eq(login_path), 'ログインページにリダイレクトされていません'
        #     expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        #   end
        # end

        # context 'ログインしている場合' do
        #   it 'フッターのリンクからレビュー一覧へ遷移できること' do
        #     login_as(me)
        #     click_on('ホーム')
        #     expect(current_path).to eq(posts_path), 'フッターのリンクからレビュー一覧画面へ遷移できません'
        #   end
        # end

        context 'レビューが一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login_as(me)
            visit posts_path
            expect(page).to have_content('まだレビューがありません'), 'レビューが一件もない場合、「レビューがありません」というメッセージが表示されていません'
          end
        end

        context 'レビューがある場合' do
          it 'レビューの一覧が表示されること' do
            post
            login_as(me)
            visit posts_path
            expect(page).to have_content(post.title), 'レビューリストにタイトルが表示されていません'
            expect(page).to have_content(post.body), 'レビューリストに本文が表示されていません'
          end
        end
      end

      describe 'レビューの作成' do
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
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            expect{ click_button '登録する' }.to change{ Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
          end

          it '本の一覧が表示される' do
            post_1 = create(:post)
            post_2 = create(:post)
            visit posts_path
            expect(page).to have_content post_1.title
            expect(page).to have_content post_2.title
          end

          it '本の詳細が表示される' do
            create(:post_author, author: author, post: post)
            visit post_path(post)
            expect(page).to have_content post.title
            expect(page).to have_content post.body
            expect(page).to have_content post.user.name
            expect(page).to have_content post.published_date
            expect(page).to have_content author.name
            expect(page).to have_link 'Googleで見る', href: post.info_link
          end

          it '本の編集ができる' do
            visit edit_post_path(post_by_me)
            fill_in 'post_body', with: 'レビュー編集'
            click_button '更新する'
            expect(current_path).to eq post_path(post_by_me)
            expect(page).to have_content 'レビューを更新しました'
            expect(page).to have_content 'レビュー編集'
          end

          # it '本の削除ができる' do
          #   visit post_path(post_by_me)
          #   title = post_by_me.title
          #   binding.pry
          #   find('#button-delete-#{post.id}').click
          #   link = find('#settings-link')
          #   link = find('.settings-link')
          #   expect{
          #     click_link '削除' 
          #     page.accept_confirm
          #     expect(page).to have_content 'レビューを削除しました'
          #   }.to change{ Post.count }.by(-1)
          #   expect(current_path).to eq posts_path
          #   expect(page).not_to have_content title
          # end

          # it '自分が追加した本には編集アイコンが表示される' do
          #   visit post_path(post_by_me)
          #   expect(page).to have_css '.fa-trash:before'
          # end

          # it '他人が追加した本には歯車アイコンが表示されない' do
          #   visit post_path(post)
          #   expect(page).not_to have_css '.fa-trash:before' 
          # end
        end

        context '異常系' do
          before { login_as(me) }
          it '検索キーワードがない場合検索されない' do
            visit search_books_path
            fill_in 'search', with: ''
            click_button '検索'
            expect(page).to have_content '検索キーワードが入力されていません'
          end

          it '入力が不足している場合、検索した本を新規追加できない' do
            visit search_books_path
            fill_in 'search', with: 'はらぺこあおむし'
            click_button '検索'
            first(".review").click
            fill_in 'post_body', with: ''
            click_button '登録する'
            expect(page).to have_content 'レビューの投稿に失敗しました'
            expect(page).to have_content '本文を入力してください'
          end

          it '入力が不足している場合、本の編集ができない' do
            visit edit_post_path(post_by_me)
            fill_in 'post_body', with: ''
            click_button '更新する'
            expect(page).to have_content 'レビューを更新できませんでした'
            expect(page).to have_content '本文を入力してください'
          end
        end
      end
  end
end
