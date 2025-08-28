# README
# プロジェクト名
furima-46290

### テーブル一覧

#### 1. usersテーブル
| カラム名          | 型         | 制約             | 説明                   |
|-------------------|------------|------------------|----------------------|
| nickname          | string     | not null         | ニックネーム          |
| email    　　　　  | string     | not null,unique  | メール               |
| encrypted_password| string     | not null         | パスワード            |
| last_name   　　　| string     | not null         | お名前（全角・姓）     |
| first_name  　　  | string     | not null         | お名前（全角・名）     |
| last_name_kana    | string     | not null         | お名前（半角・姓カナ） |
| first_name_kana   | string     | not null         | お名前（半角・名カナ） |
| birthday          | date       | not null         | 生年月日              |

#### 2. itemsテーブル
| カラム名        | 型         | 制約               | 説明                            |
|-----------------|------------|--------------------|--------------------------------|
| name            | string     | not null           | 商品名                         |
| description     | text       | not null           | 商品説明                       |
| category_id     | integer    | not null           | カテゴリー（ActiveHash想定）    |
| condition_id    | integer    | not null           | 商品状態（ActiveHash想定）      |
| postage_id      | integer    | not null           | 配送料負担（ActiveHash想定）    |
| prefecture_id   | integer    | not null           | 発送元地域（ActiveHash想定）    |
| shipping_day_id | integer    | not null           | 発送までの日数（ActiveHash想定）|
| price           | integer    | not null           | 販売価格                       |
| user            | references | 外部キー ,FK: true | 出品者（usersテーブル参照）      |

#### 3. buysテーブル
| カラム名         | 型         | 制約                       | 説明                            |
|-----------------|------------|----------------------------|---------------------------------|
| id              | bigint     | primary key                | ユニークID                       |
| user_id         | bigint     | not null, foreign key      | 購入したユーザー                 |
| items_id        | bigint     | not null, foreign key      | 購入した商品                     |
| card_token      | string     | not null                   | 決済サービスから返るカードトークン |
| created_at      | references | not null                   | 作成日時                         |
| updated_at      | references | not null                   | 更新日時                         |

#### 4. addressesテーブル
| カラム名         | 型         | 制約                       | 説明                  |
|-----------------|------------|----------------------------|-----------------------|
| postal_code     | string     | not null                   | 郵便番号               |
| prefecture      | string     | not null                   | 都道府県               |
| city            | string     | not null                   | 市区町村               |
| address         | string     | not null                   | 番地                   |
| building_name   | string     |                            | 建物名                 |
| phone_number    | string     | not null                   | 電話番号               |

---

### テーブル間の関係
- **users** 1:N **items**  
- **users** 1:N **buys** + **addresses**
- **items** 1:1 **buys** + **addresses**