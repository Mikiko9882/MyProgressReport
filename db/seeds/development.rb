3.times do
  Admin.create!(
    email: Faker::Internet.email,
    password: "12345678"
  )
end

sample_admin = SampleAdmin.create!(
  email: "sample@example.com",
  password: "12345678"
)

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

sample_school = SampleSchool.create!(
  name: 'Sample School',
  address: 'Sample Address',
  phone_number: '1234567890',
  email: 'school@example.com',
  website: 'http://www.example.com',
  code: 'sample_code',
  sample_admin_id: sample_admin.id,
)

class_names = ["1組", "2組", "3組", "4組", "5組"]

School.all.each do |school|
  class_names.each do |class_name|
    StudentClass.create!(
      name: class_name,
      school_id: school.id
    )
  end
end

class_names.each do |class_name|
  SampleStudentClass.create!(
    name: class_name,
    sample_school_id: sample_school.id
  )
end

30.times do
  Teacher.create!(
    name: Faker::Name.name,
    login_id: Faker::Lorem.characters(number: 10, min_alpha: 4, min_numeric: 1),
    password: '12345678', # 仮のパスワード
    school_id: School.pluck(:id).sample, # 学校のIDは存在するIDからランダムに選択してください
  )
end

SampleTeacher.create!(
  name: "sample先生",
  login_id: "sample1234",
  password: '12345678', 
  sample_school_id: sample_school.id
)

subject_names = ["国語", "数学", "理科", "社会" , "英語"]

Teacher.all.each do |teacher|
  subject_names.each do |subject_name|
    Subject.create!(
      subject_name: subject_name,
      teacher_id: teacher.id,
    )
  end
end

SampleTeacher.all.each do |sample_teacher|
  subject_names.each do |subject_name|
    SampleSubject.create!(
      subject_name: subject_name,
      sample_teacher_id: sample_teacher.id,
    )
  end
end

test_names = ["1学期中間テスト", "1学期期末テスト", "2学期中間テスト", "2学期期末テスト"]

Teacher.all.each do |teacher|
  test_names.each do |test_name|
    TestName.create!(
      test_name: test_name,
      teacher_id: teacher.id,
    )
  end
end

SampleTeacher.all.each do |sample_teacher|
  test_names.each do |test_name|
    SampleTestName.create!(
      test_name: test_name,
      sample_teacher_id: sample_teacher.id,
    )
  end
end

max_scores = ["100", "50", "20", "10" , "5"]
sample_max_scores = ["100"]

Teacher.all.each do |teacher|
  max_scores.each do |max_score|
    MaxScore.create!(
      max_score: max_score,
      teacher_id: teacher.id,
    )
  end
end

SampleTeacher.all.each do |sample_teacher|
  sample_max_scores.each do |max_score|
    SampleMaxScore.create!(
      max_score: max_score,
      sample_teacher_id: sample_teacher.id,
    )
  end
end

Grade.find_or_create_by!(name: "1年")
Grade.find_or_create_by!(name: "2年")
Grade.find_or_create_by!(name: "3年")

#ダミーstudent
grades = Grade.all
student_classes = StudentClass.all
sample_student_classes = SampleStudentClass.all

def generate_furigana(length)
  hiragana = ('あ'..'ん').to_a
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

SampleStudent.create!(
  name: '一年市子',
  furigana: 'いちねんいちこ',
  student_number: 'sample11',
  password: '12345678', 
  sample_school_id: sample_school.id,
  grade_id: 1,
  sample_student_class: sample_student_classes.sample
)

SampleStudent.create!(
  name: '一年二子',
  furigana: 'いちねんにこ',
  student_number: 'sample12',
  password: '12345678', 
  sample_school_id: sample_school.id,
  grade_id: 1,
  sample_student_class: sample_student_classes.sample
)

SampleStudent.create!(
  name: '二年市子',
  furigana: 'にねんいちこ',
  student_number: 'sample21',
  password: '12345678', 
  sample_school_id: sample_school.id,
  grade_id: 2,
  sample_student_class: sample_student_classes.sample
)

SampleStudent.create!(
  name: '二年二子',
  furigana: 'にねんにこ',
  student_number: 'sample22',
  password: '12345678', 
  sample_school_id: sample_school.id,
  grade_id: 2,
  sample_student_class: sample_student_classes.sample
)

SampleStudent.create!(
  name: '三年市子',
  furigana: 'さんねんいちこ',
  student_number: 'sample31',
  password: '12345678', 
  sample_school_id: sample_school.id,
  grade_id: 3,
  sample_student_class: sample_student_classes.sample
)

SampleStudent.create!(
  name: '三年二子',
  furigana: 'さんねんにこ',
  student_number: 'sample32',
  password: '12345678', 
  sample_school_id: sample_school.id,
  grade_id: 3,
  sample_student_class: sample_student_classes.sample
)

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

sample_subjects = SampleSubject.all
sample_test_names = SampleTestName.all

SampleStudent.all.each do |sample_student|
  sample_student.sample_student_class # 確認のための読み込み
  sample_student.grade # 確認のための読み込み

  sample_subjects.each do |sample_subject|
    sample_test_names.each do |sample_test_name|
      sample_max_score = SampleMaxScore.find_by(sample_teacher_id: SampleTeacher.pluck(:id).sample)
      max_score_value = sample_max_score&.max_score || 100

      score = rand(0..max_score_value) # 最大スコアまでのランダムなスコアを生成します
      achievement_rate = (score.to_f / max_score_value) * 100

      SampleTestResult.create!(
        sample_student: sample_student,
        sample_test_name: sample_test_name,
        sample_subject: sample_subject,
        score: score,
        sample_max_score: sample_max_score,
        preparation_time_minutes: rand(300),
        achievement_rate: achievement_rate
      )
    end
  end
end