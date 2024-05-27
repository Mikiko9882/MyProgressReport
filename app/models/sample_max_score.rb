class SampleMaxScore < ApplicationRecord
  belongs_to :sample_teacher
  has_many :sample_test_results, dependent: :restrict_with_exception
  has_many :sample_targets, dependent: :destroy

  validates :max_score, presence: true
end
