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
        end
      end
    end
  end
end