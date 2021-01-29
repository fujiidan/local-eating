# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | --------------------------|
| nickname           | string | null: false, unique: true |
| email              | string | null: false               |
| encrypted_password | string | null: false               |

### Association

- has_one  :profile
- has_many :stores
- has_many :comments
- has_many :communities
- has_many :messages
- has_many :likes
- has_many :like_stores, through: :likes, source: :store
- has_many :favorites
- has_many :favorite_communities, through: :favorites, source: :community



## profiles テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| address   | string     | null: false                    |
| latitude  | float      | null: false                    |
| longitude | float      | null: false                    |
| age       | integer    |                                |
| sex_id    | integer    |                                |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to_active_hash :sex


## stores テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| name      | string     | null: false                    |
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
- has_many :likes


## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| store   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :store
- has_many_attached :comment_images


## communities テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false                    |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :messages
- has_many :favorites


## messages テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| message   | string     | null: false                    |
| user      | references | null: false, foreign_key: true |
| community | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :community
- has_many_attached :message_images


## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| store  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :store


## favorites テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| community  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :community
