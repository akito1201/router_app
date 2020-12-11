require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @spot = FactoryBot.build(:post)
    end

    describe 'post情報' do
      context 'postの保存ができる場合' do
        it '必要な情報が全て存在すれば保存できること' do
          expect(@spot).to be_valid
        end
        it 'cityの情報は空でも保存できること' do
          expect(@spot).to be_valid
        end
      end

      context 'postの保存ができない場合' do
        it 'titleの情報が空だと保存できない' do
          @spot.title = nil
          @spot.valid?
          expect(@spot.errors.full_messages).to include("Title can't be blank")
        end

        it 'outlineの情報が空だと保存できない' do
          @spot.outline = nil
          @spot.valid?
          expect(@spot.errors.full_messages).to include("Outline can't be blank")
        end

        it 'prefecture_idの情報が空だと保存できない' do
          @spot.prefecture_id = nil
          @spot.valid?
          expect(@spot.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'member_idの情報が空だと保存できない' do
          @spot.member_id = nil
          @spot.valid?
          expect(@spot.errors.full_messages).to include("Member can't be blank")
        end
      end
    end
  end
end
