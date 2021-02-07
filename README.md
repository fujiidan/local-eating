# local-eating

![d5acbdef574f3f6e591158a512e293b2](https://user-images.githubusercontent.com/75054906/107138811-fd715180-6959-11eb-86c9-af30e47e570b.jpg)


## 概要

飲食店情報を共有できるアプリケーションです。地元の飲食店をターゲットにしています。

- 新たな飲食店を発見したり、自身のお気に入りの飲食店をgooglemap上に登録できます。
- 飲食店をお気に入り登録することで、自分だけのマイマップを作成することができます。
- チャット機能を使用して、地元の人達と交流することができます。

## App URL

http://18.176.242.139/


## ID/Pass

- ID   : fujiidan
- Pass : 2607

## テスト用アカウント

- Email    : test@gmail.com
- Password : test1234


## 利用方法

テストアカウントでログイン
- 飲食店を追加する！→店舗情報入力→店舗登録→店舗詳細画面にていいねする
- お気に入りリストページ→googlemap上にいいねした店舗の情報が表示される
- コミュニティ一覧ページへ！→コミュニティを作成→詳細ページへ→チャット一覧画面


## 機能一覧

- ユーザー管理機能
- 飲食店管理機能
- コミュニティ管理機能
- マイページ機能
- マイマップ機能　登録された住所といいねした店舗情報を元に、お気に入りのマップが表示される。
- コメント・メッセージ機能（非同期で実装）
- いいね・お気に入り機能（非同期で実装）
- トップページにgooglemap地図検索機能(非同期で実装)
- googlemap上に登録された飲食店のアイコンが立ち、クリックするとリンクが表示される（非同意で実装）


## 使用技術

- HTML / CSS / JavaScript / Ruby(2.6.5) / Ruby on Rails(6.0.0)
- AWS( EC2 / S3 / Nginx / Unicorn / MariaDB )
- Google API ( Maps Javascript API / Geocoding API )
- Rubocop / Rspec / Capistrano
- Git / GitHub / Visual Studio Code


## インフラ構成図

![インフラ構成図](https://user-images.githubusercontent.com/75054906/107140699-44197880-6967-11eb-8431-df67a52e2e48.png)

## 制作背景

### 目的

- 地元の飲食店の情報が一覧で表示検索できるサイトがないので、地元の人をターゲットとした、ローカライズした飲食店情報アプリを制作したいと考えました。
- 私自身の前職が飲食店であった為、地元のお客様の大切さと、地元の飲食店の集客を上げ、地域の活性化に繋げていく狙いが背景にあります。
- 好きな飲食店情報を共有したり、お気に入りの飲食店を追加することで、マイマップを作成し、地元での食事をより楽しみやすいサイトを作成したいと思いました。
- また気軽に感想を言い合ったり、飲み仲間を作るきっかけになればと思い、チャット機能を作成し、ユーザー同士で交流できる機能を作成しました。


## 工夫したポイント

- ひと目見るだけで使い方がわかるようにシンプルなデザインにしました。
- ユーザービリティを第一に考え、検索機能や非同期でストレスのないウェブページを作成しました。
- 100個以上のテストコードの実装、N+1問題を考慮した通信速度の担保、画像ファイル形式など細かいバリデーションを考慮し、アプリケーションとしてエラーや不具合が起きないように配慮した設計を目指しました.


## 課題点と実装予定の機能
- mockを利用したgoogleAPIのRspecテストの実装
- レスポンシブデザイン対応（スマホ・タブレット)
- Docker環境構築
- CI/CDパイプラインの環境構築


## ER図

![local-eating](https://user-images.githubusercontent.com/75054906/107138209-7b335e00-6956-11eb-9a55-ed584c2d1107.png)


## 画面遷移図

![local-eating(map)](https://user-images.githubusercontent.com/75054906/107138268-d5ccba00-6956-11eb-8d62-1ee3f01025e5.png)


## テーブル設計

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

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| store               | references | null: false, foreign_key: true |
| [user_id, store_id] | index      | unique: true                   |
### Association

- belongs_to :user
- belongs_to :store


## favorites テーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| user                    | references | null: false, foreign_key: true |
| community               | references | null: false, foreign_key: true |
| [user_id, community_id] | index      | unique: true                   |

### Association

- belongs_to :user
- belongs_to :community
