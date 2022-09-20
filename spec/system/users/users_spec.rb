require 'rails_helper'
  
RSpec.describe 'Users', type: :system do
  let(:existed_user) { create(:user) }

  describe 'ユーザー新規作成' do
    context '正常系' do
      it 'ユーザーの新規作成ができる' do
        visit new_user_path
        fill_in 'ユーザーネーム', with: 'test01'
        fill_in 'メールアドレス', with: 'test01@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        expect { click_button '登録' }.to change { User.count }.by(1)
        expect(page).to have_content 'ユーザー登録が完了しました'
      end
    end

    context '異常系' do
      it 'メールアドレスが未入力な場合、ユーザーの新規作成ができない' do
        visit new_user_path
        fill_in 'ユーザーネーム', with: 'test01'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        expect { click_button '登録' }.to change { User.count }.by(0)
        expect(current_path).to eq users_path
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレスを入力してください'
      end

      it 'メールアドレスが登録済な場合、ユーザーの新規作成ができない' do
        visit new_user_path
        fill_in 'ユーザーネーム', with: 'test01'
        fill_in 'メールアドレス', with: existed_user.email
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        expect { click_button '登録' }.to change { User.count }.by(0)
        expect(current_path).to eq users_path
        expect(page).to have_content 'ユーザー登録に失敗しました'
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end
    end
  end

  describe 'ユーザー詳細表示' do
    let(:me) { create(:user) }
    let(:others) { create(:user) }
    before { login_as(me) }

    context '正常系' do
      # it 'ユーザー情報が表示される' do
      #   visit user_path(others)
      #   expect(page).to have_content others.name
      # end

      # it 'ユーザーが投稿した本の一覧が表示される' do
      #   book_1 = create(:book, user: others)
      #   book_2 = create(:book, user: others)
      #   visit user_path(others)
      #   expect(page).to have_content book_1.title
      #   expect(page).to have_content book_2.title
      # end
    end
  end
end
