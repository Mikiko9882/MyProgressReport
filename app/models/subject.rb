class Subject < ApplicationRecord
  belongs_to :teacher
  validates :subject_name, presence: true
end
