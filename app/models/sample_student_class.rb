class SampleStudentClass < ApplicationRecord
  belongs_to :sample_school
  has_many :sample_students, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: { scope: :sample_school_id }
end
