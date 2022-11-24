
require 'rails_helper'
  
RSpec.describe "Admin::Users", type: :system do
  describe '確認観点3：ユーザー編集・削除（管理側）' do
    before do
      # テストデータの用意
      admin_user = create(:user, :admin) # describe使わないので、let!を使わずに記載

      # 確認対象の画面に移動
      visit '/admin/login'
    
      # labelの存在確認
      expect(page).to have_selector('label', text: 'メールアドレス'), 'email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), '@assword というラベルが表示されていることを確認してください'
    
      # labelとフィールドの対応付け確認
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
    
      # ログイン用ボタンの存在確認
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
    
      # ユーザーログイン処理
      fill_in 'メールアドレス', with: admin_user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end

    it '3-1 他人のユーザー情報の編集ができる' do
      # テストデータの用意
      other_user = create(:user, :general)

      # 確認対象の画面に移動
      visit admin_user_path(other_user)

      # 編集用ボタンの存在確認
      expect(page).to have_link('編集'), '投稿編集用のボタンが表示されていることを確認してください'

      click_on '編集'

      # labelの存在確認
      expect(page).to have_selector('label', text: 'メールアドレス'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'ユーザーネーム'), 'Last name というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'アバター'), 'Avatar というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: '権限'), 'Role というラベルが表示されていることを確認してください'

      # 更新用ボタンの存在確認
      expect(page).to have_button('更新する'), '更新用のボタンが表示されていることを確認してください'

      # ユーザー情報更新処理
      fill_in 'メールアドレス', with: 'user_edited@example.com'
      fill_in 'ユーザーネーム', with: 'last_name_edited'
      select :管理者, from: 'user[role]'

      click_button '更新する'
    end

    it '3-2：他人のユーザー情報の削除ができる' do
      # テストデータの用意
      other_user = create(:user, :general)
      
      # 確認対象の画面に移動
      visit admin_user_path(other_user)

      # 削除用ボタンの存在確認
      expect(page).to have_link('削除'), '投稿削除用のボタンが表示されていることを確認してください'
      page.accept_confirm { click_on '削除' }

      sleep 1 # 削除処理の完了まで待機
      expect(current_path).to eq('/admin/users'), '投稿削除後に一覧画面に遷移していることを確認してください'
      expect(page).not_to have_content(other_user.email), '他人のユーザー情報を削除した直後の画面に、削除した情報が表示されていないことを確認してください'
    end
  end
end
