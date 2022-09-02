  ## ■ サービス概要
　最適な絵本を見つけ、図書館で貸出可能かを確認する
「絵本検索」と「図書館検索」を掛け合わせたサービスです。
  ## ■メインのターゲットユーザー
　・子育てをしている人、今後子育てをする人、教育関係の仕事をしている人、絵本や図書館が好きな人
  ## ■ユーザーが抱える課題
  ・年齢や思考にあった絵本を探すのが難しい  
  ・絵本を図書館に借りにいったが、目当ての本が貸出中で借りれないことがある  
  ・既存の絵本検索サービスはUIが複雑なものが多く、操作をすることにストレスを感じ、図書館情報との紐付きがない  
  ## ■解決方法
  シンプルなUIで最適な絵本を見つけ、図書館の貸出情報を元に借りに行くことができる　
  ## ■実装予定の機能
  ### ログイン前の機能
- ユーザー登録  
  - ユーザー名、メールアドレス、パスワードを登録できる  
- 投稿一覧  
  - 絵本のタイトル、著者、発売日、レビュー内容、カテゴリー名を閲覧できる
- 投稿詳細  
  - 投稿一覧から選択した投稿の詳細を表示できる  
  - 絵本のタイトル、著者、発売日、レビュー内容、カテゴリー名、年齢、いいね数、コメントを表示
### ログイン後の機能
- 新規投稿  
  - 絵本を検索して、レビューを入力、カテゴリーを選択、年齢を選択して投稿できる  
- 投稿一覧  
  - 絵本のタイトル、著者、発売日、レビュー内容、カテゴリー名を閲覧できる  
- 投稿詳細  
  - 投稿一覧から選択した投稿の詳細を表示できる  
  - 絵本のタイトル、著者、発売日、レビュー内容、カテゴリー名、年齢、いいねボタン、いいね数、ブックマークボタン、コメント、図書館の貸出状況を表示  
  - 自分の投稿、コメントにのみ編集、削除が可能  
  - 図書館の貸出状況はお気に入りの図書館を登録しているユーザーのみ表示される  
- いいね機能  
  - 投稿詳細から投稿にいいねを押すことができる  
- ブックマーク機能  
  - 投稿詳細から気になった絵本をブックマークできる  
  - ブックマーク一覧を表示できる  
- コメント機能  
  - 投稿詳細から投稿に対してコメントできる  
- 年齢機能  
  - 新規投稿時に年齢を任意選択する  
  - カテゴリーは0〜6、大人の7種を設定  
- カテゴリー機能  
  - 新規投稿時にカテゴリーを任意設定する  
  - カテゴリーは楽しい、動物、笑える、食べ物、おやすみ、知育等を設定  
- 検索機能  
  - 投稿一覧をタイトル、著者、カテゴリー、年齢で検索できる  
- ランキング機能  
  - いいね数でランキングが表示できる   
- マイページ機能  
  - お気に入りの図書館を10件登録できる  
  - プロフィールを編集できる  
  - ログインユーザーの投稿一覧を閲覧できる  
- 管理ユーザー   
  - ユーザー検索、一覧、詳細、編集、削除ができる  
  - 投稿検索、一覧、詳細、編集、削除ができる  
  - カテゴリー検索、一覧、詳細、編集、削除ができる  
  - 年齢検索、一覧、詳細、編集、削除ができる
## ■なぜこのサービスを作りたいのか？
私には3歳の子供がおり絶賛子育て中です。  
子供が絵本好きなこともあり、頻繁に図書館で絵本を借りて読み聞かせをしています。  
読み聞かせをすることで、子供と一緒に笑ったり、興味があることを追求したり、親子のコミューケーションもとっています。  
一方で子供の興味が年齢やタイミングで移り変わることもあり、最適な絵本を探すことには苦労しています。  
事前に良い絵本をリサーチして図書館にいっても貸出中でがっかりしてしまったこともありました。  
本サービスではシンプルな操作で良い絵本との出会いを実現させ、自分自信及び  
同じ課題を抱える方の課題を解決をしていきたいと考えています。  

  ## ▼スケジュール
　企画〜技術調査：9/1〆切  
　README〜ER図作成：9/8 〆切  
　メイン機能実装：9/8 - 10/8  
　β版をRUNTEQ内リリース（MVP）：10/8〆切  
　本番リリース：10月末  