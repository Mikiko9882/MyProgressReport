class StudyPlan < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates :start_time, presence: true
  validates :content, presence: true
end
