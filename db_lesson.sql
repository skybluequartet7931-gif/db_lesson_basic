Q1のクエリ
MariaDB [db_lesson]> CREATE TABLE `departments`(
                  -> department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                  -> name VARCHAR(20) NOT NULL,
                  -> created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                  -> updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                  -> );

Q2のクリエ
MariaDB [db_lesson]> ALTER TABLE people ADD department_id INT UNSIGNED NULL AFTER email;

Q3のクリエ
departmentsのレコード
MariaDB [db_lesson]> INSERT INTO departments (name)
                  -> VALUES
                  -> ('営業'),
                  -> ('開発'),
                  -> ('経理'),
                  -> ('人事'),
                  -> ('情報システム');

上記departmentsのレコード作成・実行したので、department_idが自動生成されたものを下記に記載します。
department_id    name
            1    営業
            2    開発
            3    経理
            4    人事
            5    情報システム

peopleのレコード
MariaDB [db_lesson]> INSERT INTO people (name, email, department_id, age, gender)
                  -> VALUES
                  -> ('山田いちろう', 'yamada@gizumo.jp', 1, 27, 1),
                  -> ('武田かなこ', 'takeda@gizumo.jp', 1, 56, 2),
                  -> ('村上せいじ', 'murakami@gizumo.jp', 1, 39, 1),
                  -> ('井上あんな', 'inoue@gizumo.jp', 2, 24, 2),
                  -> ('水島ひろし', 'mizushima@gizumo.jp', 2, 45, 1),
                  -> ('佐藤あやか', 'satou@gizumo.jp', 2, 30, 2),
                  -> ('高橋だいき', 'takahashi@gizumo.jp', 2, 51, 1),
                  -> ('伊藤みな', 'itou@gizumo.jp', 3, 32, 2),
                  -> ('渡辺よしき', 'watanabe@gizumo.jp', 4, 47, 1),
                  -> ('小林さとし', 'kobayashi@gizumo.jp', 5, 38, 1);

上記peopleのレコード作成・実行したので、person_idが自動生成されたものを下記に記載します。
person_id    name
       17    山田いちろう
       18    武田かなこ
       19    村上せいじ
       20    井上あんな
       21    水島ひろし
       22    佐藤あやか
       23    高橋だいき
       24    伊藤みな
       25    渡辺よしき
       26    小林さとし

reportsのレコード
MariaDB [db_lesson]> INSERT INTO reports (person_id, content)
                  -> VALUES
                  -> (17, '3/1,11:00~ A社様へ商品の営業'),
                  -> (18, '3/5,14:00~ B社様と商談予定'),
                  -> (21, '3/10 単体テストの作成,コードレビュー指摘事項の修正（3件）'),
                  -> (24, '3/12 支払処理、売掛金照合'),
                  -> (17, '3/15 新規架電：20件（アポイント獲得2件）'),
                  -> (25, '3/23,13:00~ 採用面接、社会保険手続き、研修準備など'),
                  -> (20, '3/24 ユーザー登録機能のバリデーション実装（Email重複チェック）'),
                  -> (22, '3/27 バックエンド：APIエンドポイント POST /api/register の作成'),
                  -> (18, '3/30 訪問/Web商談：3件（新規1、既存2）'),
                  -> (24, '3/31 買掛金計上（計45件、仕入先A社〜M社分）');

Q4のクエリ
MariaDB [db_lesson]> UPDATE people SET department_id = CASE person_id
                  -> WHEN 1 THEN 3
                  -> WHEN 2 THEN 4
                  -> WHEN 3 THEN 5
                  -> WHEN 4 THEN 1
                  -> WHEN 6 THEN 3
                  -> END
                  -> WHERE person_id IN (1, 2, 3, 4, 5);

Q5のクエリ
MariaDB [db_lesson]> SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;

Q6
SELECT
  `name`, `email`, `age`
SELECTはテーブル内の指定したカラムを表示する役割を持っている。
この場合は、name, email, ageという3つのカラムのみを指定してテーブルに表示する。

FROM
  `people`
FROMはどのテーブルからデータを取り出すか指定する役割を持っている。
この場合は、peopleというテーブルからデータを取り出すと指定している。

WHERE
  `department_id` = 1
WHEREは特定のレコードだけを取得する役割を持っている。
この場合は、department_idというカラムの指定した1という値が一致しているレコードのみを取得する。

ORDER BY
  `created_at`;
ORDER BYはレコードの並び替えをする役割を持っている。
この場合は、created_atというカラム内のレコードを昇順に並び替える。

Q7のクエリ
MariaDB [db_lesson]> SELECT name, age, gender FROM people
                  -> WHERE (gender = 2 AND age BETWEEN 20 AND 29)
                  -> OR (gender = 1 AND age BETWEEN 40 AND 49);

Q8のクエリ
MariaDB [db_lesson]> SELECT * FROM people WHERE department_id = 1 ORDER BY age ASC;

Q9のクエリ
MariaDB [db_lesson]> SELECT AVG(age) AS average_age FROM people WHERE department_id = 2 AND gender = 2;

Q10のクエリ
MariaDB [db_lesson]> SELECT people.name, departments.name AS department_name , reports.content 
                  -> FROM people
                  -> INNER JOIN departments ON people.department_id = departments.department_id
                  -> INNER JOIN reports ON people.person_id = reports.person_id;

Q11のクエリ
MariaDB [db_lesson]> SELECT people.name FROM people
                  -> LEFT JOIN reports ON people.person_id = reports.person_id
                  -> WHERE reports.person_id IS NULL;