
 ![Image from Gyazo](https://gyazo.com/b218829eddc00b4425f0f7bed627f428.png)
  ## サービスURL
[https://www.kariteyomu.net/](https://www.kariteyomu.net/)

<br>

---
  ## ■ 概要
　最適な絵本を見つけ、図書館で貸出可能かを確認する
「絵本検索」と「図書館検索」を掛け合わせたサービスです。

## ■開発をした背景
私には小さな子供がおり絶賛子育て中です。  
子供が絵本好きなこともあり、頻繁に図書館で絵本を借りて読み聞かせをしています。  
読み聞かせをすることで、子供と一緒に笑ったり、興味があることを追求したり、親子のコミューケーションもとっています。  
一方で子供の興味が年齢やタイミングで移り変わることもあり、最適な絵本を探すことには苦労しています。  
事前に良い絵本をリサーチして図書館にいっても貸出中でがっかりしてしまったこともありました。  
本サービスではシンプルな操作で良い絵本との出会いを実現させ、自分自信及び  
同じ課題を抱える方の課題を解決をしていきたいと考えています。 
 ## ■主な機能
### 　図書館エリアを登録する
|現在地から登録|住所または郵便番号から登録する|
|---|---|
|<img src="https://gyazo.com/93a6a4a9b7629725f9427f924a1a815f.gif" width="200px" height="370px">|<img src="https://gyazo.com/4ef29384abc8c86c743078954a4a4e0b.gif" width="200px" height="370px">
|現在地付近の図書館エリアを<br>表示して登録します|住所または郵便番号を入力して<br>登録します|

<br>

 ### 絵本を検索してよみたいに追加する

 |絵本検索|よみたい|よみたい　詳細画面|
|---|---|---|
|<img src="https://gyazo.com/d4b7de0b7bb69895727b7acef3674057.gif" width="200px" height="370px">|<img src="https://gyazo.com/859127328ffe83e67b14cf9fb5094d64.gif" width="200px" height="370px">|<img src="https://gyazo.com/e852a3f73303576efa571ed4b170ef7b.gif" width="200px" height="370px">
|Google Books APIsにて<br>絵本の検索を行います|よみたいリストに追加ボタンを<br>押します| 図書館の貸出状況が表示されます<br>（予約ボタンにて予約もできます）|

<br>

 ### 絵本を検索してレビューをする

 |絵本検索|レビューをする|レビュー　詳細画面|
|---|---|---|
|<img src="https://gyazo.com/d4b7de0b7bb69895727b7acef3674057.gif" width="200px" height="370px">|<img src="https://gyazo.com/2c7b6a916a9ea96f3c1a6de84317314a.gif" width="200px" height="370px">|<img src="https://gyazo.com/40dde59ffdb32b249232b4b6cdd64412.gif" width="200px" height="370px">
|Google Books APIsにて<br>絵本の検索を行います|レビューをするボタンを押して<br>レビューを入力します| 読みたい絵本は詳細画面から<br>よみたいリストに追加できます|

<br>

## 使用技術
### バックエンド ###
 - Ruby 3.1.2
 - Rails 6.1.7
### フロントエンド ###
 - JavaScript
 - jQuery
 - Bootstrap
 - AdminLTE
### 使用したAPI ###
 - Google Books APIs
 - 図書館API(カーリル)
 - GeolocationAPI 
### インフラ ###
 - Heroku
 - AWS(S3)

## テーブル設計・ER図
![Image from Gyazo](https://gyazo.com/268d4de456d2c65564e8efece8f191d3.png)