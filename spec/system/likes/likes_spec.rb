require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  describe 'いいね機能' do
    let(:me) { create(:user) }
    let(:post) { create(:post) }
    let(:like_by_me) { create(:like, user: me) }
    before { login_as(me) }

    context '正常系' do
      it 'いいねできる' do
        visit post_path(post)
        expect(page).not_to have_selector 'i.bi.bi-heart-fill'
        expect{
          find('i.bi.bi-heart').click
          expect(page).to have_selector 'i.bi.bi-heart-fill'
        }
        expect(current_path).to eq post_path(post)
      end

      it 'いいね解除できる' do
        visit post_path(like_by_me.post)
        expect(page).not_to have_selector 'i.bi.bi-heart'
        expect{
          find('i.bi.bi-heart-fill').click
          expect(page).to have_selector 'i.bi.bi-heart'
        }
        expect(current_path).to eq post_path(like_by_me.post)
      end
    end
  end
end
