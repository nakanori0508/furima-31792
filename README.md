# テーブル設計

## users テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| nickname           | string     | NOT NULL    |
| email              | string     | NOT NULL    |
| encrypted_password | string     | NOT NULL    |
| lastname           | string     | NOT NULL    |
| firstname          | string     | NOT NULL    |
| lastname_kana      | string     | NOT NULL    |
| firstname_kana     | string     | NOT NULL    |
| birthday           | date       | NOT NULL    |

### Association
- has_many :items
- has_many :buyerinfo

## items テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| name               | string     | NOT NULL    |
| explan             | text       | NOT NULL    |
| category_id        | integer    | NOT NULL, foreign_key: true    |
| status_id          | integer    | NOT NULL, foreign_key: true    |
| shipfee_id         | integer    | NOT NULL, foreign_key: true    |
| prefecture_id      | integer    | NOT NULL, foreign_key: true    |
| dayship_id         | integer    | NOT NULL, foreign_key: true    |
| price              | integer    | NOT NULL    |

### Association
- belongs_to :user
- has_one :buyerinfo

## purchases テーブル
<!-- 配送先住所テーブル -->

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postcode           | string     | NOT NULL    |
| prefecture_id      | integer    | NOT NULL    |
| municipality       | string     | NOT NULL    |
| address            | string     | NOT NULL    |
| buildingname       | string     |      -      |
| phonenumber        | string     | NOT NULL    |
| buyerinfo_id       | integer    | NOT NULL, foreign_key: true    |


### Association
- belongs_to :buyerinfo

## buyerinfo テーブル
<!-- 購入管理テーブル -->
<!-- 購入履歴テーブル -->
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | integer    | NOT NULL, foreign_key: true    |
| item_id            | integer    | NOT NULL, foreign_key: true    |

### Association
- has_many :users
- has_many :items