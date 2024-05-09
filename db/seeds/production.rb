#admin情報
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

Grade.find_or_create_by!(name: "1年")
Grade.find_or_create_by!(name: "2年")
Grade.find_or_create_by!(name: "3年")