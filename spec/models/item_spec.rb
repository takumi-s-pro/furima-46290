require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    # テスト用のインスタンスを生成
    # buildメソッドは、DBに保存はせず、オブジェクトをメモリ上に作成する
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が出品できるとき' do
      it 'name, description, category_id, condition_id, postage_id, prefecture_id, shipping_day_id, price, imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      # --- 画像に関するテスト ---
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      # --- 商品名に関するテスト ---
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      # --- 商品の説明に関するテスト ---
      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      # --- カテゴリーに関するテスト ---
      it 'category_idが「---」(id: 1)では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      # --- 商品の状態に関するテスト ---
      it 'condition_idが「---」(id: 1)では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      # --- 配送料の負担に関するテスト ---
      it 'postage_idが「---」(id: 1)では登録できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage must be other than 1')
      end

      # --- 発送元の地域に関するテスト ---
      it 'prefecture_idが「---」(id: 1)では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end

      # --- 発送までの日数に関するテスト ---
      it 'shipping_day_idが「---」(id: 1)では登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
      end

      # --- 価格に関するテスト ---
      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが¥300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが¥9,999,999を超えると登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'priceが半角数値でないと登録できない（全角の場合）' do
        @item.price = '３００' # 全角数字
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが半角英数混合では登録できない' do
        @item.price = '300a'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが半角英語だけでは登録できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      # --- アソシエーションに関するテスト ---
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
