class Student < ApplicationRecord
  attr_accessor :current_school_code
  
  belongs_to :school
  belongs_to :grade
  belongs_to :student_class
  has_many :test_results, dependent: :destroy

  validates :name, presence: true
  validates :furigana, presence: true, format: { with: /\A[ぁ-んー－　]+\z/, allow_blank: true }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:student_number]

  validates :student_number, uniqueness: true, presence: true
  validate :student_number_format

  def student_number_format
    unless student_number.match?(/\A(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]+\z/)
      errors.add(:student_number, "は数字とアルファベットの両方を含む必要があります")
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["student_number = :value", { :value => student_number }]).first
    else
      where(conditions).first
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def average_achievement_rate
    test_results.average(:achievement_rate)
  end
      
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "grade_id", "id", "id_value", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "school_id", "student_class_id", "updated_at"]
  end
      
  def self.ransackable_associations(auth_object = nil)
    ["grade", "school", "student_class", "test_results"]
  end
end
