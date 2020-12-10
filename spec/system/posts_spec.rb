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
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
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
      expect(current_path).to eq "/posts/1/plans/new"
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
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content("SPOT作成")
    end
  end
end

RSpec.describe 'Post編集（タイトルと概要）', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context 'Postの編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したPostの編集ができる' do
      # Post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @post1.user.email
      fill_in 'user[password]', with: @post1.user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq root_path
      # Post1の詳細画面へ移動する
      visit post_path(@post1)
      # Post1に「編集」ボタンがあることを確認する
      expect(page).to have_content("編集")
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(find('input[name="post[title]"]').value).to have_content(@post1.title)
      expect(find('textarea[name="post[outline]"]').value).to have_content(@post1.outline)
      expect(find('select[name="post[prefecture_id]"]').value).to have_content(@post1.prefecture_id)
      expect(find('textarea[name="post[city]"]').value).to have_content(@post1.city)
      expect(find('select[name="post[member_id]"]').value).to have_content(@post1.member_id)
      # 投稿内容を編集する
      fill_in "post[title]", with: "編集したタイトル"
      fill_in "post[outline]", with: "編集した概要"
      # 編集してもpostモデルのカウントは変わらないことを確認する
      expect {
        find('input[value="入力完了"]')
      }.to change{ Post.count }.by(0)
      # Post1の詳細画面に遷移したことを確認する
      expect(current_path).to eq edit_post_path(@post1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のpostが存在することを確認する（タイトル）
      expect(page).to have_content(@post1.title)
      # トップページには先ほど変更した内容のpostが存在することを確認する（概要）
      expect(page).to have_content(@post1.outline)
    end
  end
  context 'Post（タイトルと概要）の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したPostの編集画面には遷移できない' do
      # Post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @post1.user.email
      fill_in 'user[password]', with: @post1.user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq root_path
      # Post2の詳細画面に遷移する
      visit post_path(@post2)
      # Post2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
    it 'ログインしていないとPostの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # Post1の詳細画面に遷移する
      visit post_path(@post1)
      # Post1に「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
      # Post2の詳細画面に遷移する
      visit post_path(@post2)
      # Post2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
  end
end

RSpec.describe 'plan編集', type: :system do
  before do
    @plan1 = FactoryBot.create(:plan)
    @plan2 = FactoryBot.create(:plan)
  end
  context 'planの編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したplanの編集ができる' do
      # plan1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @plan1.post.user.email
      fill_in 'user[password]', with: @plan1.post.user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq root_path
      # plan1の詳細画面へ移動する
      visit post_path(@plan1.post)
      # plan1に「編集」ボタンがあることを確認する
      expect(page).to have_content("編集")
      # 編集ページへ遷移する
      visit "/posts/#{@plan1.post_id}/plans/#{@plan1.id}/edit"
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(find('textarea[name="plan[place]"]').value).to have_content(@plan1.place)
      expect(find('textarea[name="plan[text]"]').value).to have_content(@plan1.text)
      # 投稿内容を編集する
      fill_in "plan[place]", with: "編集したSPOT"
      fill_in "plan[text]", with: "編集したabout"
      # 編集してもPlanモデルのカウントは変わらないことを確認する
      expect {
        find('input[value="入力完了"]').click
      }.to change{ Plan.count }.by(0)
      # Post1の詳細画面に遷移したことを確認する
      expect(current_path).to eq post_path(@plan1.post)
      # 詳細画面には先ほど変更した内容のplanが存在することを確認する（SPOT）
      expect(page).to have_content("編集したSPOT")
      # 詳細画面には先ほど変更した内容のplanが存在することを確認する（about）
      expect(page).to have_content("編集したabout")
    end
  end
  context 'planの編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したplanの編集画面には遷移できない' do
      # plan1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @plan1.post.user.email
      fill_in 'user[password]', with: @plan1.post.user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq root_path
      # plan2の詳細画面に遷移する
      visit post_path(@plan2.post)
      # plan2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
    it 'ログインしていないとplanの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # plan1の詳細画面に遷移する
      visit post_path(@plan1.post)
      # plan1に「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
      # plan2の詳細画面に遷移する
      visit post_path(@plan2.post)
      # plan2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content("編集")
    end
  end
end




RSpec.describe 'post削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context 'post削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したpostの削除ができる' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @post1.user.email
      fill_in 'user[password]', with: @post1.user.password
      find('input[value="Log in"]').click
      expect(current_path).to eq root_path
      # post1の詳細画面へ移動する
      visit post_path(@post1)
      # plan1に「削除」ボタンがあることを確認する
      expect(page).to have_content("削除")
      # 投稿を削除するとレコードの数が1減ることを確認する
      page.accept_confirm do
      expect{
        # find('a[name="post[delete]"]').click
        find_link('削除', href: post_path(@post1)).click
      }.to change{Post.count}.by(-1)
      end
      # 削除完了画面に遷移したことを確認する
      # 「削除が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページにはpost1の内容が存在しないことを確認する（画像）
      # トップページにはpost1の内容が存在しないことを確認する（テキスト）
    end
  end
  # context 'post削除ができないとき' do
  #   it 'ログインしたユーザーは自分以外が投稿したpostの削除ができない' do
  #     # post1を投稿したユーザーでログインする
  #     # post2に「削除」ボタンが無いことを確認する
  #   end
  #   it 'ログインしていないとpostの削除ボタンがない' do
  #     # トップページに移動する
  #     # post1に「削除」ボタンが無いことを確認する
  #     # post2に「削除」ボタンが無いことを確認する
  #   end
  # end
end