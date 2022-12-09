require 'rails_helper'

RSpec.describe 'Libraries', type: :system do
  describe '図書館のCRUD' do
    let(:me) { create(:user) }
    let(:post) { create(:post) }
    let(:post_by_me) { create(:post, user: me) }
    let(:author) { create(:author) }
    let(:age) { create(:age) }
    let(:category) { create(:category) }
    let(:category_b) { create(:category_2) }
    let(:library) { create(:library, user: me) }

    describe '図書館リスト' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit libraries_path
          expect(current_path).to eq(login_path), 'ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it 'フッターのリンクから図書館一覧へ遷移できること' do
          login_as(me)
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
        end
      

        it '住所を入力して図書館登録できること' do
          login_as(me)
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          expect(page).to have_content '図書館エリア登録'
          expect(page).to have_content '現在地から登録をする'
          expect(page).to have_content '住所または郵便番号で登録する'
          fill_in 'address', with: '神奈川県　平塚市'
          click_on '検索'
          choose '神奈川県平塚市'
          click_on '登録する'
          expect(page).to have_content '図書館情報を登録しました'
        end

        it '図書館登録の後でエリア変更できること' do
          login_as(me)
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          fill_in 'address', with: '神奈川県　平塚市'
          click_on '検索'
          choose '神奈川県平塚市'
          click_on '登録する'
          expect(page).to have_content '図書館情報を登録しました'
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          expect(page).to have_content '登録しているエリアは神奈川県平塚市です'
          expect(page).to have_content 'エリアを変更する'
          expect(page).to have_content 'エリアを削除する'
          click_on 'エリアを変更する'
          fill_in 'address', with: '神奈川県　平塚市'
          click_on '検索'
          choose '神奈川県大磯町'
          click_on '登録する'
          expect(page).to have_content '図書館情報を登録しました'
        end

        it '図書館登録の後でエリア削除できること' do
          login_as(me)
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          fill_in 'address', with: '神奈川県　平塚市'
          click_on '検索'
          choose '神奈川県平塚市'
          click_on '登録する'
          expect(page).to have_content '図書館情報を登録しました'
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          expect(page).to have_content '登録しているエリアは神奈川県平塚市です'
          expect(page).to have_content 'エリアを変更する'
          expect(page).to have_content 'エリアを削除する'
          accept_alert do
            click_on 'エリアを削除する'
          end
          expect(page).to have_content '図書館エリア登録'
        end

        it 'エリア削除の後で再度エリア登録できること' do
          login_as(me)
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          fill_in 'address', with: '神奈川県　平塚市'
          click_on '検索'
          choose '神奈川県平塚市'
          click_on '登録する'
          expect(page).to have_content '図書館情報を登録しました'
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          expect(page).to have_content '登録しているエリアは神奈川県平塚市です'
          expect(page).to have_content 'エリアを変更する'
          expect(page).to have_content 'エリアを削除する'
          accept_alert do
            click_on 'エリアを削除する'
          end
          expect(page).to have_content '図書館エリア登録'
          fill_in 'address', with: '神奈川県　平塚市'
          click_on '検索'
          choose '神奈川県平塚市'
          click_on '登録する'
          expect(page).to have_content '図書館情報を登録しました'
          click_on '図書館', match: :first
          expect(current_path).to eq(libraries_path), 'フッターのリンクから図書館一覧画面へ遷移できません'
          expect(page).to have_content '登録しているエリアは神奈川県平塚市です'
          expect(page).to have_content 'エリアを変更する'
          expect(page).to have_content 'エリアを削除する'
        end
      end
    end    
  end
end
