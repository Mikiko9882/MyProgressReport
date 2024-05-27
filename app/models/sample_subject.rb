class SampleSubject < ApplicationRecord
  belongs_to :sample_teacher
  has_many :sample_test_results, dependent: :restrict_with_exception
  has_many :sample_targets, dependent: :destroy

  validates :subject_name, presence: true
end
