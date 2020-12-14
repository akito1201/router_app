# MySpot
![_M](https://user-images.githubusercontent.com/73152774/102006195-8f961880-3d62-11eb-8029-abc78a28167e.png)


## Description
  休日のお出かけプランを立てるのに困ったことはありませんか？MySpotは、ユーザーがおすすめの場所（以下SPOT）を共有できるアプリケーションです。友人同士、家族での外出やデートなど、様々なシチュエーションに応じてSPOTを共有し合い、参考にし合える場になることを期待しています。

## URL
 http://3.113.239.68:3000/

## テスト用アカウント
  Basic認証（ID: admin, password: 2222)  
  email: test@com  
  password: aaa111


## DEMO
### トップページ
テスト用アカウントでログイン → トップページから「SPOT作成」押下 → SPOT情報入力→SPOT投稿

### 新規投稿作成画面
「SPOT作成」押下 → SPOTの概要入力 → SPOT詳細入力
![ec680c17f12eda392d884a022610ff37](https://user-images.githubusercontent.com/73152774/102014637-54afd700-3d9a-11eb-9fd6-909867a7a83f.gif)
SPOTの概要にはタイトル・概要・場所情報、メンバー情報（誰と一緒に行くか）を入力します。SPOT詳細には、具体的なSPOT名とその概要に加え、写真を投稿することもできます。「SPOTを追加する」を押下することで、複数のSPOTを登録することができます。

### 詳細表示画面
SPOT概要をクリック → 詳細画面に遷移
![669e89cd446e26e61dad4f6a07cf2abd (1)](https://user-images.githubusercontent.com/73152774/102006562-6d51ca00-3d65-11eb-8351-3789863021c0.gif)
トップページにはSPOTの概要が一覧表示されています。それらをクリックすることで、該当SPOTの詳細を閲覧することができます。投稿したユーザーであれば、後からSPOT詳細を追加することができます。

### 編集画面
SPOT詳細画面 → 「編集」押下 → SPOT編集画面へ遷移 → 投稿内容の編集
![9f4d38461816d1c8fcf88dc49475ab56](https://user-images.githubusercontent.com/73152774/102011167-f2e57200-3d85-11eb-85f5-98de52c2c4cb.gif)
ユーザーは、自身が投稿したSPOTを編集することができます。

## 制作背景
家族との外出をできる限り充実したものにしたいと思い、作成しました。有名スポットから、ガイドブックなどには載っていない穴場まで、こだわりのスポットを共有できる場があれば、外出の際のヒントになるのではないかと考えました。




## 工夫したポイント
行きたい場所の探しやすさを追求するため、検索機能とお気に入り登録機能を実装しました。ほとんどのユーザーは、場所から検索をすると考え、プルダウンで都道府県を選択し、場所を限定した上で検索できるように工夫しました。さらに、検索結果の中からスポットを選ぶ基準が必要と考え、お気に入り登録機能を実装しました。登録したスポットを一覧で表示できることはもちろん、各投稿にお気に入り登録数を表示させることで投稿の人気度を確認でき、ユーザーがスポットを選ぶ際に参考にすることができます。

## 使用技術（開発環境）
### バックエンド
  Ruby/Ruby on Rails
### フロントエンド
  HTML, CSS, JavaScript, Ajax
### データベース
  MySQL, SequelPro
### インフラ
  AWS(EC2)
### アプリケーションサーバ（本番環境）
  unicorn
### ソース管理
  GitHub, GitHubDesktop
### テスト
  RSpec
### エディタ
  VSCode

## 課題
  現段階では、ユーザー同士の交流ができないことが課題として挙げられます。投稿について、ユーザーが感想を述べたり、意見交換することができれば、新たなアイデアが生まれ、活性化していくと考えています。したがって、コメント投稿機能を追加で実装することで、よりよいアプリケーションにバージョンアップしていきたい思います。



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
  