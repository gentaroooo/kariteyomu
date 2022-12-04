
require 'rails_helper'
  
RSpec.describe "Admin::UserSessions", type: :system do
  describe 'ユーザーログイン（管理側）' do
    it '1-1 admin権限のあるユーザーでログインができる' do
      admin_user = create(:user, :admin)
      visit '/admin/login'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
      # ユーザーログイン処理
      fill_in 'メールアドレス', with: admin_user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      # 処理結果の確認
      expect(page).to have_content 'ログインしました'
      expect(current_path).not_to eq('/admin/login'), 'ログイン処理が正しく行えるかを確認してください'
      expect(current_path).to eq('/admin'), 'ログイン後に管理画面に遷移できていません'
    end

    it '1-2：admin権限のないユーザーでログインができない' do
      general_user = create(:user, :general)
      visit '/admin/login'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
      # ユーザーログイン処理
      fill_in 'email', with: general_user.email
      fill_in 'password', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content '権限がありません'
    end

    it '1-3：存在しないユーザーでログインができない' do
      admin_user = create(:user, :admin) 
      visit '/admin/login'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
      # ユーザーログイン処理
      fill_in 'メールアドレス', with: 'another_user@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content 'ログインに失敗しました'
      expect(current_path).not_to eq('/admin'), '存在しないユーザーでログインできていないかを確認してください'
      expect(current_path).to eq('/admin/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end

    it '1-4：パスワードが間違っている場合にログインができない' do
      admin_user = create(:user, :admin) 
      visit '/admin/login'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      # ログイン用ボタンの存在確認
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
      fill_in 'メールアドレス', with: admin_user.email
      fill_in 'パスワード', with: 'wrong_password'
      click_button 'ログイン'
      expect(page).to have_content 'ログインに失敗しました'
      expect(current_path).not_to eq('/admin'), 'パスワードが間違っている場合にログインできていないかを確認してください'
      expect(current_path).to eq('/admin/login'), 'ログインの失敗時に別の画面の遷移していないかを確認してください'
    end
  end

  describe '確認観点2：ユーザーログアウト' do
    it '2-1：ユーザーのログアウトができる' do
      admin_user = create(:user, :admin) 
      visit '/admin/login'
      expect(page).to have_selector('label', text: 'メールアドレス'), 'Email というラベルが表示されていることを確認してください'
      expect(page).to have_selector('label', text: 'パスワード'), 'Password というラベルが表示されていることを確認してください'
      expect(page).to have_css("label[for='email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_css("label[for='password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
      expect(page).to have_button('ログイン'), 'ログイン用のボタンが表示されていることを確認してください'
      # ユーザーログイン処理
      fill_in 'メールアドレス', with: admin_user.email
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
    end

    it '2-2：ログインしていない場合、ユーザーのログアウトリンクが表示されない' do
      visit '/admin/login'
      expect(page).not_to have_link('ログアウト'), 'ログインしていない場合でも、ログアウトリンクが表示されています'
    end
  end
end
