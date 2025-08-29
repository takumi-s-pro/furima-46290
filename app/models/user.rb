class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム必須
  validates :nickname, presence: true

  # 名前（全角ひらがな・カタカナ・漢字）
  validates :last_name,  presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "は全角で入力してください" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "は全角で入力してください" }

  # フリガナ（全角カタカナ）
  validates :last_name_kana,  presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }

  # 誕生日必須
  validates :birthday, presence: true

  # パスワード
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i, message: "は6文字以上で英字と数字の両方を含めて設定してください" }


  has_many :items
  has_many :buys
end
