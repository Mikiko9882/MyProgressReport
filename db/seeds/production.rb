#admin情報
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

sample_admin = SampleAdmin.create!(
  email: "sample@example.com",
  password: "12345678"
)

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

class_names.each do |class_name|
  SampleStudentClass.create!(
    name: class_name,
    sample_school_id: sample_school.id
  )
end

SampleTeacher.create!(
  name: "sample先生",
  login_id: "sample1234",
  password: '12345678', 
  sample_school_id: sample_school.id
)

subject_names = ["国語", "数学", "理科", "社会" , "英語"]

SampleTeacher.all.each do |sample_teacher|
  subject_names.each do |subject_name|
    SampleSubject.create!(
      subject_name: subject_name,
      sample_teacher_id: sample_teacher.id,
    )
  end
end

test_names = ["1学期中間テスト", "1学期期末テスト", "2学期中間テスト", "2学期期末テスト"]

SampleTeacher.all.each do |sample_teacher|
  test_names.each do |test_name|
    SampleTestName.create!(
      test_name: test_name,
      sample_teacher_id: sample_teacher.id,
    )
  end
end

sample_max_scores = ["100"]

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

sample_student_classes = SampleStudentClass.all

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

      # 目標を作成
      if score > 0
        min_target_score = [0, score - rand(0..10)].max # テスト結果のスコア以下のランダムな目標スコアを生成します
      else
        min_target_score = 0
      end

      target_score = rand(min_target_score..max_score_value) # テスト結果のスコア以上または以下のランダムな目標スコアを生成します
      target_preparation_time_minutes = rand(300)

      sample_student.sample_targets.create!(
        sample_test_name: sample_test_name,
        sample_subject: sample_subject,
        sample_max_score: sample_max_score,
        target_score: target_score,
        target_preparation_time_minutes: target_preparation_time_minutes
      )
    end
  end
end