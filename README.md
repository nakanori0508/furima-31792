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
- has_many :purchases

## items テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| name               | string     | NOT NULL    |
| explan             | text       | NOT NULL    |
| category_id        | integer    | NOT NULL    |
| status_id          | integer    | NOT NULL    |
| shipFee_id         | integer    | NOT NULL    |
| prefecture_id      | integer    | NOT NULL    |
| dayship_id         | integer    | NOT NULL    |
| price              | integer    | NOT NULL    |

### Association
- belongs_to :user

## purchases テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postCode           | string     | NOT NULL    |
| prefecture_id      | string     | NOT NULL    |
| municipality       | string     | NOT NULL    |
| address            | string     | NOT NULL    |
| buildingname       | string     |      -      |
| phonenumber        | string     | NOT NULL    |

### Association
- belongs_to :user

## buyerinfo テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user_id            | integer    | NOT NULL, foreign_key: true    |
| item_id            | integer    | NOT NULL, foreign_key: true    |