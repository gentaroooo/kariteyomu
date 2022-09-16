require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:post_by_others) { create(:post) }

  describe '投稿のCRUD' do
    describe '投稿の一覧' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit posts_path
          expect(current_path).to eq(login_path), 'ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it 'ヘッダーのリンクから投稿一覧へ遷移できること' do
          login_as(user)
          click_on('投稿')
          click_on('投稿一覧')
          expect(current_path).to eq(posts_path), 'ヘッダーのリンクから投稿一覧画面へ遷移できません'
        end

        context '投稿が一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login_as(user)
            visit posts_path
            expect(page).to have_content('投稿がありません'), '投稿が一件もない場合、「投稿がありません」というメッセージが表示されていません'
          end
        end

        context '投稿がある場合' do
          it '投稿の一覧が表示されること' do
            post
            login_as(user)
            visit posts_path
            expect(page).to have_content(post.title), '投稿一覧画面に投稿のタイトルが表示されていません'
            expect(page).to have_content(post.body), '投稿一覧画面に投稿の本文が表示されていません'
          end
        end
      end
    end
  end

  describe '投稿の作成' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        visit new_post_path
        expect(current_path).to eq(login_path)
        expect(page).to have_content('ログインしてください')
      end
    end

    context 'ログインしている場合' do
      before do
        login_as(user)
        click_on('投稿')
        click_on('投稿作成')
      end

      it '投稿が作成できること' do
        fill_in 'タイトル', with: 'テストタイトル'
        fill_in '本文', with: 'テスト本文'
        click_button '登録する'
        expect(current_path).to eq(posts_path)
        expect(page).to have_content('投稿を作成しました')
        expect(page).to have_content('テストタイトル')
        expect(page).to have_content('テスト本文')
      end

      it '投稿の作成に失敗すること' do
        fill_in 'タイトル', with: 'テストタイトル'
        click_button '登録する'
        expect(page).to have_content('投稿を作成できませんでした')
        expect(page).to have_content('本文を入力してください')
      end
    end
  end

  # describe '投稿の詳細' do
  #   context 'ログインしていない場合' do
  #     it 'ログインページにリダイレクトされること' do
  #       visit post_path(post)
  #       expect(current_path).to eq login_path
  #       expect(page).to have_content 'ログインしてください'
  #     end
  #   end

  #   context 'ログインしている場合' do
  #     before do
  #       post
  #       login_as(user)
  #     end
  #     it '投稿の詳細が表示されること' do
  #       visit posts_path
  #       within "#post-id-#{post.id}" do
  #         click_on post.title
  #       end
  #       expect(page).to have_content post.title
  #       expect(page).to have_content post.user.name
  #       expect(page).to have_content post.body
  #     end
  #   end
  # end

  # describe '投稿のCRUD' do
  #   describe '投稿の編集' do
  #     context '他人の投稿の場合' do
  #       it '編集ボタン・削除ボタンが表示されないこと' do
  #         login_as(user)
  #         visit post_path post_by_others
  #         expect(page).not_to have_selector("#button-edit-#{post_by_others.id}")
  #         expect(page).not_to have_selector("#button-delete-#{post_by_others.id}")
  #       end
  #     end
  #     context '自分の投稿の場合' do
  #       it '編集ボタン・削除ボタンが表示されること' do
  #         login_as(user)
  #         visit post_path post
  #         expect(page).to have_selector("#button-edit-#{post.id}")
  #         expect(page).to have_selector("#button-delete-#{post.id}")
  #       end
  #     end
    end
  end
end