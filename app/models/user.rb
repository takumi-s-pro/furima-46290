class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム必須
  validates :nickname, presence: true

  # 名前（全角ひらがな・カタカナ・漢字）
  validates :last_name,  presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }

  # フリガナ（全角カタカナ）
  validates :last_name_kana,  presence: true,
                              format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }

  # 誕生日必須
  validates :birthday, presence: true

  # パスワード
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i, message: 'is invalid. Include both letters and numbers' }

  has_many :items
  # has_many :buys
end
