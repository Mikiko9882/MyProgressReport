class StudentClass < ApplicationRecord
  belongs_to :school
  has_many :students, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: { scope: :school_id }
end
