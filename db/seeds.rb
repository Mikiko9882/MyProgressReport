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


Grade.find_or_create_by!(name: "1年")
Grade.find_or_create_by!(name: "2年")
Grade.find_or_create_by!(name: "3年")