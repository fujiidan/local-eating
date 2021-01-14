# テーブル設計

## users テーブル

| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| nickname           | string | null: false, uniqueness: true |
| email              | string | null: false, uniqueness: true |
| encrypted_password | string | null: false                   |

### Association

- has_one  :profile
- has_many :stores
- has_many :comments
- has_many :communities
- has_many :messages


## profiles テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| address | string     |                                |
| age     | integer    |                                |
| sex_id  | integer    |                                |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to_active_hash :sex


## stores テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| name      | string     | null: false, uniqueness: true  |
| address   | string     | null: false                    |
| latitude  | float      | null: false                    |
| longitude | float      | null: false                    |
| url       | string     |                                |
| genre_id  | integer    | null: false                    |
| price_id  | integer    | null: false                    |
| info      | string     | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many_attached :images
- belongs_to_active_hash :genre
- belongs_to_active_hash :price


## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| store   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :store
- has_many_attached :images


## communities テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false                    |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :messages


## messages テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| message   | string     | null: false                    |
| user      | references | null: false, foreign_key: true |
| community | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :community
- has_many_attached :images