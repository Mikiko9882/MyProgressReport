class School < ApplicationRecord
  belongs_to :admin
  has_many :student_classes, dependent: :restrict_with_exception
  
  before_validation :generate_unique_code, on: :create

  has_many :teachers, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/}
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP}
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp}, allow_blank: true

  validates :code, presence: true, uniqueness: true

  def generate_unique_code
    loop do
      self.code = SecureRandom.hex(4)
      break unless School.exists?(code: code)
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "code", "created_at", "email", "id", "id_value", "name", "phone_number", "updated_at", "website"]
  end
end
