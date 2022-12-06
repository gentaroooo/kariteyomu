require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'レビューのCRUD' do
    let(:me) { create(:user) }
    let(:post) { create(:post) }
    let(:post_by_me) { create(:post, user: me) }
    let(:author) { create(:author) }
    let(:age) { create(:age) }
    let(:category) { create(:category) }
    let(:category_b) { create(:category_2) }
    let(:library) { create(:library, user: me) }

      describe 'レビューリスト' do
        context 'ログインしていない場合' do
          it 'ログしてなくてもレビュー一覧が表示されること' do
            visit posts_path
            expect(current_path).to eq(posts_path), 'レビュー一覧が表示されていません'
          end
        end

        context 'ログインしている場合' do
          it 'フッターのリンクからレビュー一覧へ遷移できること' do
            login_as(me)
            click_on('ホーム')
            expect(current_path).to eq(root_path), 'フッターのリンクからレビュー一覧画面へ遷移できません'
          end
        end

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
          before do
            login_as(me)
            category
            age
            library
          end

          it '検索した本を新規追加できる（カテゴリー1、年齢1）' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            check '0〜1歳'
            check '幼稚園保育園'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
          end

          it '検索した本を新規追加できる（カテゴリー0、年齢1）' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            check '0〜1歳'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
          end

          it '検索した本を新規追加できる（カテゴリー1、年齢0）' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            check '幼稚園保育園'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
          end

          it '検索した本を新規追加できる（カテゴリー0、年齢0）' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
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
            expect(page).to have_link 'Google', href: post.info_link
          end
          
          it '検索した本の詳細を選択すると図書館情報が表示される(はらぺこあおむし）' do
            visit search_books_path
            fill_in 'search', with: 'はらぺこあおむし'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
            visit post_path(1)
            sleep 5
            expect(page).to have_content '予約する'
          end

          it '検索した本の詳細を選択すると図書館情報が表示される(くまくまパン)' do
            visit search_books_path
            fill_in 'search', with: 'くまくまパン'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
            visit post_path(1)
            sleep 5
            expect(page).to have_content '予約する'
          end

          it '検索した本の詳細を選択すると図書館情報が表示される(図書館に書籍がないケース)' do
            visit search_books_path
            fill_in 'search', with: '実践Rails'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
            visit post_path(1)
            sleep 5
            expect(page).to have_content '図書館に本がありません'
          end

          it '検索した本の詳細を選択すると図書館情報が表示される(ISBN無し)' do
            visit search_books_path
            fill_in 'search', with: 'おおかみと7ひきのこやぎ'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
            visit post_path(1)
            sleep 5
            expect(page).to have_content '検索できません'
          end

          it '本の詳細から年齢で絞りこむ' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            check '0〜1歳'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'

            visit post_path(me)
            click_on '0〜1歳'
            expect(current_path).to eq posts_path
            first(".card-link").click
            expect(page).to have_content '0〜1歳'
          end

          it '本の詳細からカテゴリーで絞りこむ' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            check '幼稚園保育園'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'

            visit post_path(me)
            click_on '幼稚園保育園'
            expect(current_path).to eq posts_path
            first(".card-link").click
            expect(page).to have_content '幼稚園保育園'
          end

          it '本の編集ができる' do
            visit edit_post_path(post_by_me)
            fill_in 'post_body', with: 'レビュー編集'
            click_button '更新する'
            expect(current_path).to eq post_path(post_by_me)
            expect(page).to have_content 'レビューを更新しました'
            expect(page).to have_content 'レビュー編集'
          end

          it '本の削除ができる' do
            visit post_path(post_by_me)
            accept_alert do
              click_on 'button-delete-1'
            end  
            expect(page).to have_content 'レビューを削除しました'
          end
        end

        context '異常系' do
          before do
            login_as(me)
            category
            age
            library
          end

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

          it 'ログインして投稿した後にログアウトしてPOSTの詳細' do
            visit search_books_path
            fill_in 'search', with: 'apple'
            click_button '検索'
            first(".review").click
            expect(current_path).to eq new_post_path
            fill_in 'post_body', with: 'レビューした内容'
            check '幼稚園保育園'
            expect { click_button '登録する' }.to change { Post.count }.by(1)
            expect(current_path).to eq posts_path
            expect(page).to have_content 'レビューを投稿しました'
            find(".dropdown-toggle").click
            click_on 'ログアウト'
            expect(page).to  have_content 'ログアウトしました'
            visit post_path(me)
            expect(page).to  have_content 'ログインしてエリア登録すると、図書館の貸出情報が表示されます'
          end
        end
      end
  end
end
