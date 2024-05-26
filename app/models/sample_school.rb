class SampleSchool < ApplicationRecord
  belongs_to :sample_admin
  has_many :sample_student_classes, dependent: :restrict_with_exception
  has_many :sample_teachers, dependent: :destroy
  has_many :sample_students, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP}
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp}, allow_blank: true

  validates :code, presence: true, uniqueness: true

end
