class SampleGrade < ApplicationRecord
  has_many :sample_students, dependent: :restrict_with_exception

  validates :name, presence: true
end
