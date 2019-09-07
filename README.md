# Product Manager Conference 2019 公式Webサイト


## デザイン・コンテンツの更新対象と仕組み

### デザインの変更

- 以下のフォルダ内の各ファイルを編集することで、実施できます

```
pmconfjp2019/source/assets/images
pmconfjp2019/source/assets/stylesheets
pmconfjp2019/source/assets/javascripts
```

- imagesフォルダには以下の画像も格納されます
    - speaker
    - sponsor
    - staff



### コンテンツレイアウトおよび本文の変更

- 以下のフォルダ内の `.slim` 拡張子のファイルを編集することで、実施できます

```
/pmconfjp2019/source`
```

### コンテンツ内に埋め込んだデータ

- 以下のフォルダ内の `.yml` 拡張子のファイルを編集することで、実施できます

```
pmconfjp2019/data
```

- 管理している情報は以下の通りです
    - speaker(登壇者情報)
    - sponsor(スポンサー情報)
    - staff(実行委員)
    - job(スポンサー求人情報)

### コンテンツ内に埋め込んだ記事の追加・更新

- 記事のファイル名フォーマットは、`YYYY-MM-DD-TITLE.html.md` となっています。
    - 例) `2019-11-12-first-post.html.md`
- このファイル内では、以下のフォーマットに沿って記述する必要があります
    - **※dateはファイル名の日付と一致している必要があります。**
- [記事ファイル内のフォーマット](https://github.com/htomine/pmconf/blob/master/article_template.erb)

categoryに `eventreport` を指定すると、http://2019.sendaiitfes.org/articles/categories/eventreport.html に記事が表示されます。

### Tipsの追加・更新

- 以下のフォルダ内の各ファイルを編集することで、実施できます。

```
pmconfjp2019/source/tips
```

- ファイル名は `TITLE.html.md` というフォーマットである必要があります。  
    - 例) `group-work-guide.md`
- ファイル内では以下のフォーマットに沿って記述する必要があります。  
- [記事ファイル内のフォーマット](https://github.com/htomine/pmconf/blob/master/tips_template.erb)


## ローカル環境の設定

### ローカル環境の前提条件
- Ruby 2.3.1
	- rbenv を利用して導入するのを推奨
    - 参考URL) http://qiita.com/issobero/items/e0443b79da117ed48294
	- `bundler` をインストールしておく
- node
	- nvm  や nodenv などを利用して導入するのがよい
    - npm install できればなんでも良い

### ローカルで初期設定

リポジトリにディレクトリ直下で以下を実施

```
bundle install
npm install
gem install middleman
gem install rake -v 11.3.0
```

### ローカルで起動する

```
bundle exec middleman build --verbose # ファイルのビルド
bundle exec middleman --verbose       # 起動
```

- 上記のコマンドを実行すると起動ログの中にアクセスするURLが表示される
    - 例) `http://localhost:4567`


## CI/CDの設定
- 設定は `.travis.yml` に記載する
- ファイル内に存在しない変数は2種類ある
    - Travis内で自動的に定義してくれる変数
        - 例) TRAVIS_BRANCH
    - `secure:xxxxx` で暗号化されているもの
        - 例) GH_TOKEN
        - 暗号化の方法については [ここから](https://docs.travis-ci.com/user/encryption-keys/) 
- あとは公式のドキュメントをみたらだいたいわかる
    - https://docs.travis-ci.com/

