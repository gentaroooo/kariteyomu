require 'rails_helper'
 
RSpec.describe Library, type: :model do

  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      library= build(:library)
      expect(library).to be_valid
    end
  end

  context 'nameが存在しない場合' do
    it '無効であること' do
      library = build(:library, name: nil)
      expect(library).to_not be_valid
    end
  end
end