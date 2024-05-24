# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_24_071320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "grades", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "max_scores", force: :cascade do |t|
    t.integer "max_score", null: false
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_max_scores_on_teacher_id"
  end

  create_table "sample_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_sample_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sample_admins_on_reset_password_token", unique: true
  end

  create_table "sample_schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "email"
    t.string "website"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sample_admin_id", null: false
    t.index ["code"], name: "index_sample_schools_on_code", unique: true
    t.index ["sample_admin_id"], name: "index_sample_schools_on_sample_admin_id"
  end

  create_table "sample_teachers", force: :cascade do |t|
    t.string "name"
    t.string "login_id", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sample_school_id", null: false
    t.index ["login_id"], name: "index_sample_teachers_on_login_id", unique: true
    t.index ["reset_password_token"], name: "index_sample_teachers_on_reset_password_token", unique: true
    t.index ["sample_school_id"], name: "index_sample_teachers_on_sample_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "email"
    t.string "website"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id", null: false
    t.index ["admin_id"], name: "index_schools_on_admin_id"
    t.index ["code"], name: "index_schools_on_code", unique: true
  end

  create_table "student_classes", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_student_classes_on_school_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "student_number", default: "", null: false
    t.string "name"
    t.string "furigana"
    t.bigint "school_id"
    t.bigint "grade_id"
    t.bigint "student_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["grade_id"], name: "index_students_on_grade_id"
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["student_class_id"], name: "index_students_on_student_class_id"
    t.index ["student_number"], name: "index_students_on_student_number", unique: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject_name", null: false
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_subjects_on_teacher_id"
  end

  create_table "targets", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "test_name_id"
    t.bigint "subject_id"
    t.bigint "max_score_id"
    t.integer "target_score"
    t.integer "target_preparation_time_minutes"
    t.float "target_achievement_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["max_score_id"], name: "index_targets_on_max_score_id"
    t.index ["student_id"], name: "index_targets_on_student_id"
    t.index ["subject_id"], name: "index_targets_on_subject_id"
    t.index ["test_name_id"], name: "index_targets_on_test_name_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.string "login_id", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["login_id"], name: "index_teachers_on_login_id", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  create_table "test_names", force: :cascade do |t|
    t.string "test_name", null: false
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_test_names_on_teacher_id"
  end

  create_table "test_results", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "test_name_id"
    t.bigint "subject_id"
    t.bigint "max_score_id"
    t.integer "score", null: false
    t.integer "preparation_time_minutes", null: false
    t.float "achievement_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["max_score_id"], name: "index_test_results_on_max_score_id"
    t.index ["student_id"], name: "index_test_results_on_student_id"
    t.index ["subject_id"], name: "index_test_results_on_subject_id"
    t.index ["test_name_id"], name: "index_test_results_on_test_name_id"
  end

  add_foreign_key "max_scores", "teachers"
  add_foreign_key "sample_schools", "sample_admins"
  add_foreign_key "sample_teachers", "sample_schools"
  add_foreign_key "schools", "admins"
  add_foreign_key "student_classes", "schools"
  add_foreign_key "students", "grades"
  add_foreign_key "students", "schools"
  add_foreign_key "students", "student_classes"
  add_foreign_key "subjects", "teachers"
  add_foreign_key "targets", "max_scores"
  add_foreign_key "targets", "students"
  add_foreign_key "targets", "subjects"
  add_foreign_key "targets", "test_names"
  add_foreign_key "teachers", "schools"
  add_foreign_key "test_names", "teachers"
  add_foreign_key "test_results", "max_scores"
  add_foreign_key "test_results", "students"
  add_foreign_key "test_results", "subjects"
  add_foreign_key "test_results", "test_names"
end
