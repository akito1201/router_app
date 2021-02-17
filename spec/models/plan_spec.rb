require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '#create' do
    before do
      @plan = FactoryBot.build(:plan)
    end

    describe 'plan情報' do
      context 'planの保存ができる場合' do
        it '必要な情報が全て存在すれば保存できること' do
          expect(@plan).to be_valid
        end
      end

      context 'planの保存ができない場合' do
        it 'placeの情報が空だと保存できない' do
          @plan.place = nil
          @plan.valid?
          expect(@plan.errors.full_messages).to include("Place can't be blank")
        end

        it 'textの情報が空だと保存できない' do
          @plan.content = nil
          @plan.valid?
          expect(@plan.errors.full_messages).to include("Content can't be blank")
        end
      end
    end
  end
end
