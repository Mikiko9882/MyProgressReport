3.times do
  Admin.create!(
    email: Faker::Internet.email,
    password: "12345678"
  )
end

6.times do
  School.create!(
    name: Faker::Educator.secondary_school,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.subscriber_number(length: 10),
    email: Faker::Internet.email,
    website: Faker::Internet.url,
    code: Faker::Alphanumeric.alphanumeric(number: 8, min_alpha: 3),
    admin_id: Admin.pluck(:id).sample,
  )
end

class_names = ["1組", "2組", "3組", "4組", "5組", "6組", "7組", "8組", "9組", "10組"]

School.all.each do |school|
  class_names.each do |class_name|
    StudentClass.create!(
      name: class_name,
      school_id: school.id
    )
  end
end

30.times do
  Teacher.create!(
    name: Faker::Name.name,
    login_id: Faker::Lorem.characters(number: 10, min_alpha: 4, min_numeric: 1),
    password: '12345678', # 仮のパスワード
    school_id: School.pluck(:id).sample, # 学校のIDは存在するIDからランダムに選択してください
  )
end

subject_names = ["国語", "数学", "理科", "社会" , "英語"]

Teacher.all.each do |teacher|
  subject_names.each do |subject_name|
    Subject.create!(
      subject_name: subject_name,
      teacher_id: teacher.id,
    )
  end
end

test_names = ["1学期中間テスト", "1学期期末テスト", "2学期中間テスト", "2学期期末テスト" , "3学期中間テスト", "3学期期末テスト", "小テスト", "実力テスト"]

Teacher.all.each do |teacher|
  test_names.each do |test_name|
    TestName.create!(
      test_name: test_name,
      teacher_id: teacher.id,
    )
  end
end

max_scores = ["100", "50", "20", "10" , "5"]

Teacher.all.each do |teacher|
  max_scores.each do |max_score|
    MaxScore.create!(
      max_score: max_score,
      teacher_id: teacher.id,
    )
  end
end

Grade.find_or_create_by!(name: "1年")
Grade.find_or_create_by!(name: "2年")
Grade.find_or_create_by!(name: "3年")

#ダミーstudent
grades = Grade.all
student_classes = StudentClass.all

def generate_furigana(length)
  hiragana = ('ぁ'..'ん').to_a
  furigana = ''
  length.times { furigana << hiragana.sample }
  furigana
end

40.times do
  Student.create!(
    name: Faker::Name.name,
    furigana: generate_furigana(5),
    student_number: Faker::Lorem.characters(number: 10, min_alpha: 4, min_numeric: 1),
    password: '12345678', 
    school_id: School.pluck(:id).sample, # 学校のIDは存在するIDからランダムに選択してください
    grade: grades.sample,
    student_class: student_classes.sample
  )
end

40.times do |index|
  student_id = Student.pluck(:id).sample
  test_name_id = TestName.pluck(:id).sample
  subject_id = Subject.pluck(:id).sample
  max_score = MaxScore.find_by(teacher_id: Teacher.pluck(:id).sample)

  # 対応するテストの最大スコアが存在しない場合はデフォルト値を使用します
  max_score_value = max_score ? max_score.max_score : 100

  TestResult.create!(
    student_id: student_id,
    test_name_id: test_name_id,
    max_score_id: max_score&.id,
    score: rand(0..max_score_value), # 最大スコアまでのランダムなスコアを生成します
    subject_id: subject_id,
    preparation_time_minutes: rand(300),
  )
end