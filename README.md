# テーブル設計

## users テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| nickname      | string     | NOT NULL    |
| email         | string     | NOT NULL    |
| password      | string     | NOT NULL    |
| name          | string     | NOT NULL    |
| name_kana     | string     | NOT NULL    |
| birthday      | string     | NOT NULL    |

## items テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| itemName      | string     | NOT NULL    |
| itemExplan    | text       | NOT NULL    |
| itemCategory  | string     | NOT NULL    |
| itemStatus    | string     | NOT NULL    |
| itemShipFee   | string     | NOT NULL    |
| prefecture    | string     | NOT NULL    |
| itemDayShip   | string     | NOT NULL    |
| itemPrice     | integer    | NOT NULL    |

## purchases テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| cardInfo      | text       | NOT NULL    |
| expDate       | integer    | NOT NULL    |
| securityCode  | integer    | NOT NULL    |
| postCode      | string     | NOT NULL    |
| prefecture    | string     | NOT NULL    |
| municipality  | text       | NOT NULL    |
| address       | text       | NOT NULL    |
| buildingName  | text       | NOT NULL    |
| phoneNumber   | integer    | NOT NULL    |