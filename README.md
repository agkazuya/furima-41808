# テーブル設計

## user テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |
| date_of_birth      | date   | null: false |


## item テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| name               | string     | null: false |
| description        | text       | null: false |
| price              | integer    | null: false |
| condition_id       | integer    | null: false |
| category_id        | integer    | null: false |
| shipping_cost_id   | integer    | null: false |
| shipping_region_id | integer    | null: false |
| shipping_time_id   | integer    | null: false |
| user               | references | null: false, foreign_key: true |


## order テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

## shipping_address テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| postal_code        | string     | null: false |
| shipping_region_id | integer    | null: false |
| address_city       | string     | null: false |
| address_line       | string     | null: false |
| build              | string     |
| phone_number       | string     | null: false |
| order              | references | null: false, foreign_key: true |


### Association
user model
has_many : items
has_many : orders


item model
belongs_to :user
has_one    :order


order model
belongs_to :user
belongs_to :item
has_one    :shipping_address


shipping_address model
belongs_to :order
