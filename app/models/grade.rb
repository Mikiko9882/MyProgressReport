class Grade < ApplicationRecord
  has_many :students, dependent: :restrict_with_exception

  has_many :sample_students, dependent: :restrict_with_exception

  validates :name, presence: true
end
