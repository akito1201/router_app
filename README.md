# テーブル設計

## users テーブル

| Column          | Type   | Options                   |
| --------        | ------ | -----------               |
| email           | string | null: false, unique: true |
| encrypted_password| string | null: false             |
| nickname        | string | null: false, unique: true |


## association
has_many :posts
has_many :comments
has_many :favorites

## posts テーブル

| Column       | Type            | Options          |
| ---------    | ------          | -----------      |
| outline      | text            | null: false      |
| prefecture_id| integer         | null: false      |
| city         | string          | null: false      |
| member_id    | integer         | null: false      |
| time_id      | integer         | null: false      |
| user         | references      | foreign_key: true|

## association
  belongs_to :user
  has_many :comments
  has_many :plans
  has_many :favorites


## plans テーブル

| Column     | Type          | Options           |
| ---------  | ------        | -----------       |
| text       | datetime      | null: false       |
| image      | ActiveRecord  |                   |
| post_id    | references    | foreign_key: true |
| place      | string        | null: false       |

## association
  belongs_to :post



  ## favorites テーブル

| Column        | Type      | Options           |
| ---------     | ------    | -----------       |
| checked       | boolean   |                   |
| post_id       | references| foreign_key: true |
| user_id       | references| foreign_key: true |


## association
  belongs_to :post
  belongs_to :user


## comments テーブル ##################

| Column        | Type      | Options           |
| ---------     | ------    | -----------       |
| text          | text      | null: false       |
| user_id       | references| foreign_key: true |
| post_id       | references| foreign_key: true |


## association #####################
  belongs_to :user
  belongs_to :post
  