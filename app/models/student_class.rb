class StudentClass < ApplicationRecord
  belongs_to :school

  validates :name, presence: true, uniqueness: { scope: :school_id }
end
