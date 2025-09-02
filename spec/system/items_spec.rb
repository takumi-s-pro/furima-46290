require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    # テスト用のユーザーと、そのユーザーが出品する商品のダミーデータを作成
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item) # createではなくbuildにして、まだDBに保存しない
  end

  context '商品が出品できるとき' do
    it 'ログインしたユーザーは商品を出品できる' do
      # 1. ログインする
      sign_in(@user) # supportファイルがなくてもこのファイル内で定義済みのメソッドを使用

      # 2. トップページに「出品する」ボタンがあることを確認する
      expect(page).to have_content('出品する')

      # 3. 出品ページへ移動する
      visit new_item_path

      # 4. フォームに情報を入力する
      attach_file 'item-image', Rails.root.join('spec/fixtures/files/test_image.png')
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.description
      select 'レディース', from: 'item-category_id'
      select '新品・未使用', from: 'item-condition_id'
      select '送料込み（出品者負担）', from: 'item-postage_id'
      select '東京都', from: 'item-prefecture_id'
      select '1~2日で発送', from: 'item-shipping-day_id'
      fill_in 'item-price', with: @item.price

      # 5. 入力価格に応じた手数料と利益が表示されていることを確認する
      tax = (@item.price * 0.1).floor
      profit = @item.price - tax
      expect(page).to have_selector('#add-tax-price', text: tax.to_s)
      expect(page).to have_selector('#profit-price', text: profit.to_s)

      # 6. 「出品する」ボタンを押すと、Itemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)

      # 7. トップページに遷移することを確認する
      expect(current_path).to eq(root_path)

      # 8. トップページには先ほど出品した商品の画像と情報が表示されていることを確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
    end
  end

  context '商品出品ができないとき' do
    it 'ログインしていても、入力情報に不備があると出品できず、エラーメッセージと共にページが再描画される' do
      # 1. ログインする
      sign_in(@user)

      # 2. 出品ページへ移動する
      visit new_item_path

      # 3. フォームに空の情報を入力して「出品する」ボタンを押す
      fill_in 'item-name', with: '' # 商品名を空にする

      # 4. Itemモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)

      # 5. 出品ページに戻される（パスが変わらない）ことを確認する
      expect(current_path).to eq(items_path)

      # 6. エラーメッセージが表示されていることを確認する
      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'ログイン状態によるアクセス制御' do
    it 'ログアウト状態のユーザーは商品出品ページへ遷移しようとすると、ログインページへリダイレクトされる' do
      # 1. トップページにアクセス
      visit root_path

      # 3. 直接URLを叩いて出品ページへ行こうとする
      visit new_item_path

      # 4. ログインページにリダイレクトされていることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end

  
  def sign_in(user)
    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
  end
end