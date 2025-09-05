require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  describe '購入情報の保存' do
    before do
      # テストで使用するユーザーと商品をあらかじめ作成しておく
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      # テスト対象のインスタンスを生成（FactoryBotとuser, itemを関連付ける）
      @buy_address = FactoryBot.build(:buy_address, user_id: @user.id, item_id: @item.id)
      # テストの実行が遅くならないようにsleepを入れる
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@buy_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @buy_address.building_name = ''
        expect(@buy_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @buy_address.token = nil
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空だと保存できないこと' do
        @buy_address.postal_code = ''
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buy_address.postal_code = '1234567'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'prefecture_idが0では保存できないこと' do
        @buy_address.prefecture_id = 0
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @buy_address.city = ''
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @buy_address.address = ''
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @buy_address.phone_number = ''
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下では保存できないこと' do
        @buy_address.phone_number = '090123456'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'phone_numberが12桁以上では保存できないこと' do
        @buy_address.phone_number = '090123456789'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'phone_numberに半角数字以外が含まれている場合は保存できないこと' do
        @buy_address.phone_number = '090-1234-5678'
        @buy_address.valid?
        expect(@buy_address.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'userが紐付いていないと保存できないこと' do
        @buy_address.user_id = nil
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @buy_address.item_id = nil
        @buy_address.valid?
        # ★期待するエラーメッセージを、実際の出力に合わせて英語に変更
        expect(@buy_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

