RSpec.describe 'ログイン・ログアウト', type: :system do
  let(:user) { create(:user) }

  describe '通常画面' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit login_path
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(current_path).to eq root_path
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
          expect(page).to have_content('けんさく')
          expect(page).to have_content('よみたい')
          expect(page).to have_content('図書館')
        end
      end
      context 'メールアドレスが空の場合' do
        it 'ログインに失敗すること' do
          visit login_path
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(current_path).to eq login_path
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
      context 'パスワードが空の場合' do
        it 'ログインに失敗すること' do
          visit login_path
          fill_in 'メールアドレス', with: 'user.email'
          fill_in 'パスワード', with: ''
          click_button 'ログイン'
          expect(current_path).to eq login_path
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
    end
  end
end