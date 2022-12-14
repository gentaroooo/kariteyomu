require 'rails_helper'
  
RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン' do
    context '正常系' do
      it 'ログインができる' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード',	with: 'password'
        click_button 'ログイン'
        expect(page).to  have_content 'ログインしました'
      end

      it 'ログアウトができる' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード',	with: 'password'
        click_button 'ログイン'
        expect(page).to  have_content 'ログインしました'
        find(".dropdown-toggle").click
        click_on 'ログアウト'
        expect(page).to  have_content 'ログアウトしました'
      end
    end

    context '異常系' do
      it '入力が不足している場合、ログインできない' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード',	with: ''
        click_button 'ログイン'
        expect(current_path).to eq login_path
        expect(page).to  have_content 'ログインに失敗しました'
      end
    end
  end

  describe 'ゲストログイン' do
    context '正常系' do
      it 'ログインができる' do
        visit login_path
        click_button 'ゲストログイン'
        expect(page).to  have_content 'ログインしました'
      end

      it 'ログアウトができる' do
        visit login_path
        click_button 'ゲストログイン'
        expect(page).to  have_content 'ログインしました'
        find(".dropdown-toggle").click
        click_on 'ログアウト'
        expect(page).to  have_content 'ログアウトしました'
      end
    end
  end
end
