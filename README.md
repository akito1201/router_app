# MySpot

## Description
  休日のお出かけプランを立てるのに困ったことはありませんか？MySpotは、ユーザーがおすすめのスポットを共有できるアプリケーションです。友人同士、家族での外出やデートなど、様々なシチュエーションに応じておすすめのスポットを共有し合い、参考にし合える場になることを期待しています。

## URL
 (http://3.113.239.68:3000/)

## テスト用アカウント
  Basic認証（ID: admin, password: 2222)  
  nickname: test  
  password: aaa111

## Usage
  テストアカウントでログイン→トップページから「SPOT作成」押下→SPOT情報入力→SPOT投稿

## 制作背景
  週末家族で

## 工夫したポイント
  行きたい場所の探しやすさを追求するため、検索機能とお気に入り登録機能を実装しました。ほとんどのユーザーは、場所から検索をすると考え、プルダウンで都道府県を選択し、場所を限定した上で検索できるように実装しました。さらに、検索結果の中からスポットを選ぶ基準が必要と考え、お気に入り登録機能を実装しました。登録したスポットを一覧で表示できることはもちろん、各投稿にお気に入り登録数を表示させることで、ユーザーがスポットを選ぶ際に参考にすることができます。

## 使用技術（開発環境）
　Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code


## 課題
  現段階では、ユーザー同士の交流ができないことが課題として挙げられます。投稿について、ユーザーが感想を述べたり、意見交換することができれば、新たなアイデアが生まれ、活性化していくと考えています。よって、コメント投稿機能を追加で実装することで、よりよいアプリケーションにバージョンアップしていければと思います。



## DB設計

### users テーブル

| Column            | Type   | Options                   |
| --------          | ------ | -----------               |
| email             | string | null: false, unique: true |
| encrypted_password| string | null: false               |
| nickname          | string | null: false, unique: true |


### association
has_many :posts
has_many :favorites

### posts テーブル

| Column       | Type            | Options          |
| ---------    | ------          | -----------      |
| outline      | text            | null: false      |
| prefecture_id| integer         | null: false      |
| city         | string          | null: false      |
| member_id    | integer         | null: false      |
| user_id      | references      | foreign_key: true|

### association
  belongs_to :user
  belongs_to :member
  belongs_to :prefecture
  has_many :plans
  has_many :favorites
  has_many :favorite_counts


### plans テーブル

| Column     | Type          | Options           |
| ---------  | ------        | -----------       |
| text       | text          | null: false       |
| post_id    | references    | foreign_key: true |
| place      | string        | null: false       |

### association
  belongs_to :post



  ### favorites テーブル

| Column        | Type      | Options           |
| ---------     | ------    | -----------       |
| checked       | boolean   |                   |
| post_id       | references| foreign_key: true |
| user_id       | references| foreign_key: true |


### association
  belongs_to :post
  belongs_to :user


### favorite_counts テーブル

| Column        | Type      | Options           |
| ---------     | ------    | -----------       |
| count         | integer   | null: false       |
| post_id       | references| foreign_key: true |


### association
  belongs_to :post
  