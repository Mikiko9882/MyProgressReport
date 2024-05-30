# サービス名: My Progress Report
[![Image from Gyazo](https://i.gyazo.com/3b9d9476285cc3be6170a7004b44fcf9.jpg)](https://gyazo.com/3b9d9476285cc3be6170a7004b44fcf9)

## サービス概要
My Progress Reportは、テスト成績を管理するアプリです。このアプリでは、ユーザーはテストの名前、取得点数、そして最大得点が何点かを入力し、自動的に達成率が計算されます。また、これまでのテスト履歴を一覧で確認し、達成率の推移を折れ線グラフで視覚的に把握することが可能です。また、ユーザーはグラフを使って成績の推移や勉強時間との関係を視覚的に確認できます。

## このサービスへの思い・作りたい理由
職場で実践した小テストでの経験から、生徒が自分の成績を折れ線グラフで視覚化することがやる気向上に効果的であることを確認しました。ただし、個々の生徒のデータを一つずつ折れ線グラフにする手間が大きな課題でした。また、異なる種類のテストを受験している中で、成長率を正確に把握することが難しいと感じていました。
この経験から、生徒が受験したテストを素早くグラフ化し、複数のテストを組み合わせた総合的な成績の視覚化が可能なサービスの需要があると感じました。このようなサービスを通じて、生徒が各テストごとの達成率や総合的な成長度を簡単に把握できることで、教師が個々の生徒の進捗を迅速に理解し、的確なサポートを提供できるようになると考えています。

## 機能紹介
「👤」がついているものは、管理者機能。
「👩‍🏫」がついているものは、先生用機能。
「👥」がついているものは、生徒用機能です。

|トップ画面| 👤 学校登録機能 |
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/3ea6ee8e367ae2dfbff75f05ed748b0c.gif)](https://gyazo.com/3ea6ee8e367ae2dfbff75f05ed748b0c)|[![Image from Gyazo](https://i.gyazo.com/b5584e5be81eba58fee83a595bed1361.png)](https://gyazo.com/b5584e5be81eba58fee83a595bed1361)|
|このアプリで学生、生徒ができること、管理者へのログインを誘導しています。|まずは、学校を登録します。学校が登録されると自動で学校コードが発行されます。それは、先生や生徒がログインする時の学校コードになります。|

| 👤 先生、クラス名追加機能 | 👤 先生の編集機能 |
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/3f342cc72ca305161a83f067b3b34234.gif)](https://gyazo.com/3f342cc72ca305161a83f067b3b34234)|[![Image from Gyazo](https://i.gyazo.com/5e5d5a31d82e5231eee913d3acb773e7.gif)](https://gyazo.com/5e5d5a31d82e5231eee913d3acb773e7)|
|学校を登録したら、学校の先生やクラス名を登録することができます。|登録した先生を編集することができます。|

| 👩‍🏫 テスト要素追加機能 | 👩‍🏫 生徒一覧機能 |
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/0ab1c7e326794c2adc2df591a636351b.gif)](https://gyazo.com/0ab1c7e326794c2adc2df591a636351b)|[![Image from Gyazo](https://i.gyazo.com/b2220df83fb74d606e52a7f6aa54c6bc.gif)](https://gyazo.com/b2220df83fb74d606e52a7f6aa54c6bc)|
|テストの科目や、テスト名、満点などテストの要素を追加することができます。|生徒一覧機能から、学校の生徒一覧を確認することができます。そこから生徒の詳細見たり、編集を行ったりすることができます。|

| 👩‍🏫 テスト結果一覧機能 | 👩‍🏫 平均達成率ランキング |
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/846f3a2fad7484cad955719663405c58.gif)](https://gyazo.com/846f3a2fad7484cad955719663405c58)|[![Image from Gyazo](https://i.gyazo.com/742fc40a9204eb8b7574156b60815c8e.gif)](https://gyazo.com/742fc40a9204eb8b7574156b60815c8e)|
|テスト結果一覧画面で、生徒の成長をグラフで確認できたり、そのテストの生徒の目標などの詳細情報、編集を行うことができます。|全てのテストの平均達成率を出し、学年ごとのランキングを確認することができます。|

| 👥 テスト結果入力機能 | 👥 テスト結果編集機能 |
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/36b7fcae37bbdb03d7e6283cb24aa666.gif)](https://gyazo.com/36b7fcae37bbdb03d7e6283cb24aa666)|[![Image from Gyazo](https://i.gyazo.com/8971b2a360a27fa1cb9eb418986f9e1c.gif)](https://gyazo.com/8971b2a360a27fa1cb9eb418986f9e1c)|
|テスト結果を入力します。先生が事前に登録した、テスト名、満点、教科がドロップダウンで出てくるようにして、入力する手間を省いています。|登録したテスト結果を編集したり、削除したりすることができます。|

| 👥 グラフで見る機能 | 👥 目標を設定する機能 |
|:-:|:-:|
|[![Image from Gyazo](https://i.gyazo.com/51af809c55b196848aab2049abd42bdd.gif)](https://gyazo.com/51af809c55b196848aab2049abd42bdd)|[![Image from Gyazo](https://i.gyazo.com/0bb6a7d791eb89aaa832fd46ce9c95c9.gif)](https://gyazo.com/0bb6a7d791eb89aaa832fd46ce9c95c9)|
|テスト結果を入力すると、教科ごとのグラフを作成してくれます。また、学習時間と達成率の相関図も確認することができます。|テストに向けて、目標を設定することができます。|

| 👥 目標とテスト結果を比較する機能 |
|:-:|
|[![Image from Gyazo](https://i.gyazo.com/0a165c41dec122197e248f052012d301.png)](https://gyazo.com/0a165c41dec122197e248f052012d301)|
|目標とテスト結果の比較ができます。目標を達成したら緑で目標達成、達成できなかったら青で目標未達成と表示されます。|

## 技術構成
### 使用技術
| カテゴリ | 技術 |
| --- | --- |
| フロントエンド | Rails 7.1.3.2 (Hotwire/Turbo), Bootstrap |
| バックエンド | Rails 7.1.3.2 (Ruby 3.1.4 ) |
| データベース | PostgreSQL |
| インフラ | Heroku |

### ER図
[![Image from Gyazo](https://i.gyazo.com/3ecf7029bb650f3395d4483793381116.png)](https://gyazo.com/3ecf7029bb650f3395d4483793381116)