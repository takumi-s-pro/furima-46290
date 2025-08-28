# README
# プロジェクト名
furima-46290

### テーブル一覧

#### 1. usersテーブル
| カラム名            | 型         | 制約                       | 説明                  |
|--------------------|------------|----------------------------|----------------------|
| nickname           | string     | null: false                | ニックネーム          |
| email              | string     | null: false, unique: true  | メール               |
| encrypted_password | string     | null: false                | パスワード            |
| last_name          | string     | null: false                | お名前（全角・姓）     |
| first_name         | string     | null: false                | お名前（全角・名）     |
| last_name_kana     | string     | null: false                | お名前（半角・姓カナ） |
| first_name_kana    | string     | null: false                | お名前（半角・名カナ） |
| birthday           | date       | null: false                | 生年月日              |


### Association
has_many :items
has_many :buys


#### 2. itemsテーブル
| カラム名        | 型          | 制約                           | 説明                            |
|-----------------|------------|--------------------------------|--------------------------------|
| name            | string     | null: false                    | 商品名                         |
| description     | text       | null: false                    | 商品説明                       |
| category_id     | integer    | null: false                    | カテゴリー（ActiveHash想定）    |
| condition_id    | integer    | null: false                    | 商品状態（ActiveHash想定）      |
| postage_id      | integer    | null: false                    | 配送料負担（ActiveHash想定）    |
| prefecture_id   | integer    | null: false                    | 発送元地域（ActiveHash想定）    |
| shipping_day_id | integer    | null: false                    | 発送までの日数（ActiveHash想定）|
| price           | integer    | null: false                    | 販売価格                       |
| user            | references | null: false, foreign_key: true | 出品者（usersテーブル参照）      |


### Association
has_one :buy


#### 3. buysテーブル
| カラム名      | 型         | 制約                           | 説明               |
|--------------|------------|--------------------------------|-------------------|
| user         | references | null: false, foreign_key: true | 購入したユーザー   |
| item         | references | null: false, foreign_key: true | 購入した商品       |


### Association
belongs_to :user
belongs_to :item
has_one :address


#### 4. addressesテーブル
| カラム名         | 型         | 制約                           | 説明                     |
|-----------------|------------|--------------------------------|-------------------------|
| postal_code     | string     | null: false                    | 郵便番号                 |
| prefecture_id   | integer    | null: false                    | 都道府県（ActiveHash想定）|
| city            | string     | null: false                    | 市区町村                 |
| address         | string     | null: false                    | 番地                     |
| building_name   | string     |                                | 建物名                   |
| phone_number    | string     | null: false                    | 電話番号                 |
| buy             | references | null: false, foreign_key: true | 購入情報                 |


### Association
belongs_to :buy

---

