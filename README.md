# テーブル設計

## user テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| username           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| date_of_birth      | date   | null: false |


## item テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| name            | string     | null: false |
| description     | text       | null: false |
| price           | string     | null: false |
| condition       | string     | null: false |
| category        | string     | null: false |
| shipping_cost   | string     | null: false |
| stock_quantity  | string     | null: false |
| shipping_region | string     | null: false |
| shipping_time   | date       | null: false |
| user            | references | null: false, foreign_key: true |


## order テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |
| quantity       | string     | null: false |
| purchase_price | string     | null: false |
| purchase_date  | date       | null: false |
| payment_method | string     | null: false |
| status         | string     | null: false |


## shipping_address テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| receiver_name | string     | null: false |
| postal_code   | string     | null: false |
| address_state | string     | null: false |
| address_city  | string     | null: false |
| address_line  | string     | null: false |
| build         | string     | null: false |
| phone_number  | string     | null: false |
| order         | references | null: false, foreign_key: true |


### Association
user model
has_many : items
has_many : order


item model
belongs_to :user
has_one    :order


order model
belongs_to :user
belongs_to :item
has_one    :shipping_address


shipping_address model
belongs_to :order
