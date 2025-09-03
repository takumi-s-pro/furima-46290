require 'rails_helper'

RSpec.describe 'トップページ ヘッダー', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:user) { FactoryBot.create(:user) }

  context 'ログアウト状態の場合' do
    it '新規登録とログインボタンが表示される' do
      visit root_path
      expect(page).to have_link '新規登録', href: new_user_registration_path
      expect(page).to have_link 'ログイン', href: new_user_session_path
      expect(page).not_to have_content user.nickname
      expect(page).not_to have_link 'ログアウト'
    end

    it '新規登録ボタンをクリックすると新規登録ページに遷移する' do
      visit root_path
      click_link '新規登録'
      expect(current_path).to eq new_user_registration_path
    end

    it 'ログインボタンをクリックするとログインページに遷移する' do
      visit root_path
      click_link 'ログイン'
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'ログイン状態の場合' do
    before do
      visit new_user_session_path
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'ログイン'
    end

    it 'ユーザーのニックネームとログアウトボタンが表示される' do
      visit root_path
      expect(page).to have_content user.nickname
      expect(page).to have_link 'ログアウト'
    end

    it 'ログアウトボタンをクリックするとログアウトできる' do
      visit root_path
      click_link 'ログアウト'
      expect(page).to have_link '新規登録'
      expect(page).to have_link 'ログイン'
    end
  end
end
