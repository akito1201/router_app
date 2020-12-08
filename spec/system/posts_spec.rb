require 'rails_helper'

RSpec.describe 'SPOT投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
    @plan = FactoryBot.build(:plan)
  end
  context 'SPOT投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('SPOT作成')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in "post[title]", with: @post.title
      fill_in "post[outline]", with: @post.outline
      select '神奈川県', from: 'post[prefecture_id]'
      fill_in "post[city]", with: @post.city
      select 'デートで', from: 'post[member_id]'
      # 「SPOT詳細入力へ」をクリックするとPostモデルのカウントが1上がることを確認する
      expect {
        find('input[value="SPOT詳細入力へ"]').click
      }.to change{ Post.count }.by(1)
      # SPOT詳細入力ページに遷移することを確認する
      expect(current_path).to eq "/posts/:post_id/plans/new"
      # 「投稿する」をクリックするとPlanモデルのカウントが1上がることを確認する
      fill_in "plan[place]", with: @plan.place
      fill_in "plan[text]", with: @plan.text
      # 「投稿する」をクリックするとPlanモデルのカウントが1上がることを確認する
      expect {
        find('input[value="投稿する"]').click
      }.to change{ Plan.count }.by(1)
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容のSPOTが存在することを確認する
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@post.outline)
    end
  end
  context 'SPOT投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのリンクがない
    end
  end
end