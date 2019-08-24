# Product Manager Conference 2018 公式Webサイト

## ■1. デザイン・コンテンツの更新対象と仕組みについて

### 1-1. デザインの変更

以下のフォルダ内の各ファイルを編集することで、実施できます。

`\pmconfjp2018\source\assets\images`

`\pmconfjp2018\source\assets\stylesheets`

`\pmconfjp2018\source\assets\javascripts`

### 1-2. コンテンツレイアウトおよび本文の変更

以下のフォルダ内の `.slim` 拡張子のファイルを編集することで、実施できます。

`\pmconfjp2018\source`

### 1-3. コンテンツ内に埋め込んだデータ

以下のフォルダ内の `.yml` 拡張子のファイルを編集することで、実施できます。

`\pmconfjp2018\data`

### 1-4. コンテンツ内に埋め込んだ記事の追加・更新

記事のファイル名フォーマットは、`YYYY-MM-DD-TITLE.html.md` となっています。

例) `2018-11-10-first-post.html.md`

このファイル内では、以下のフォーマットに沿って記述する必要があります。  

**※dateはファイル名の日付と一致している必要があります。**

[記事ファイル内のフォーマット](https://github.com/htomine/pmconf/blob/master/article_template.erb)

categoryに `eventreport` を指定すると、http://2018.sendaiitfes.org/articles/categories/eventreport.html に記事が表示されます。

### 1-5.  Tipsの追加・更新

以下のフォルダ内の各ファイルを編集することで、実施できます。

`\pmconfjp2018\source\tips`

ファイル名は `TITLE.html.md` というフォーマットである必要があります。  

例) `group-work-guide.md`

また、ファイル内では以下のフォーマットに沿って記述する必要があります。  

[記事ファイル内のフォーマット](https://github.com/htomine/pmconf/blob/master/tips_template.erb)

## ■2. デザイン・コンテンツの更新方法について

### 2-1. 更新方法 その1

軽微な更新であれば、開発環境を用意せずに更新が可能です。
一番簡単な更新手順としては、以下となります。

1. Web画面上で、編集したい箇所を特定。
2. Web画面上で、ソースコードの右上にある鉛筆アイコン（Edit this file）をクリック。
3. Web画面上で、編集。
4. Web画面上で、画面下部にあるCommit changesに、変更概要を記入し、「Commit changes」ボタンをクリック。
5. 2分後ぐらいに、自動で本番環境に反映 https://travis-ci.org/fullvirtue/pmconfjp2018 を確認し、 `build` が `passed` になることを確認。もし `errored` になった場合は、画面下部に赤字でエラーになった箇所が表示されるので、エラー内容を確認し修正後、4.に戻る。
6. 本番環境にアクセスして、表示内容を確認。

### 2-2. 更新方法 その2

手元のテキストエディタ等で更新したい場合は、git の環境を用意する必要があります。

Windows環境、Mac環境ともに、以下の手順となります。

#### 2-2-A) 環境準備

1. SourceTree (無料) をダウンロードし、インストール。 https://ja.atlassian.com/software/sourcetree
2. SourceTree を起動。
3. SourceTree上で、このリポジトリを clone。

#### 2-2-B) 更新手順

1. 最新版の `master` ブランチを `pull` 。
2. 任意のテキストエディタを開き、編集したい箇所を特定。
3. 任意のテキストエディタ上で、編集し、保存。
4. SourceTree上で、`commit` & `push`。
5. 2分後ぐらいに、自動で本番環境に反映 https://travis-ci.org/fullvirtue/pmconfjp2018 を確認し、 `build` が `passed` になることを確認。もし `errored` になった場合は、画面下部に赤字でエラーになった箇所が表示されるので、エラー内容を確認し修正後、保存し、4.に戻る。
6. 本番環境にアクセスして、表示内容を確認。

### 2-3. 更新方法 その3

手元にデモ環境を用意し、正しく表示が出来ることを確認してから本番環境に反映したい場合、開発環境そのものを構築することになります。

Mac環境では、以下の手順となります。

#### 2-3-A) 環境構築

##### 2-3-A-a) Homebrew のインストール

Homebrewへのパスをbash_profileに追記する。

`$ vim ~/.bash_profile`

export PATH=/usr/local:$PATH
Homebrewでインストールされるソフトウェアの保存先が無ければ作成する。

`$ sudo mkdir /usr/local/`

Homebrewをインストールする。

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

先ほど編集したbash_profileを再読み込み。

    $ source ~/.bash_profile

インストールできているか確認

    $ brew -v
    Homebrew 0.9.5

##### 2-3-A-b) rbenv のインストール

（20180908-riku編集 ざっくり書いてます）

こちら参考にお願いします
http://qiita.com/issobero/items/e0443b79da117ed48294

##### 2-3-A-c) ローカル環境にデプロイ（htmlファイルなどを生成する）

2-2を参考にローカル環境に本リポジトリをクローン

ルートディレクトリ（/pmconfjp2018）で以下のコマンドを実行

```■最初の1回目

rm -rf ~/.nvm
git clone https://github.com/creationix/nvm.git ~/.nvm
cd ~/.nvm
git checkout `git describe --abbrev=0 --tags`
source ~/.nvm/nvm.sh
nvm install "$TRAVIS_NODE_VERSION"
npm install

■最初の1回目＆2回目以降はここから

bundle exec middleman build --verbose

■デプロイするときだけ実行するので、ローカルではやらないのが普通

[ "$TRAVIS_BRANCH" == "master" ]
[ $GH_TOKEN ]
bundle exec middleman deploy
``` 

/pmconfjp2018/build の中にサイトができてるはず。

上記コマンドの
`bundle exec middleman build --verbose`
を実行するたびに、変更が反映されたものがビルドされる。
