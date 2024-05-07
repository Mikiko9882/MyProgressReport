class Target < ApplicationRecord
  belongs_to :student
  belongs_to :test_name
  belongs_to :subject
  belongs_to :max_score

  before_save :calculate_target_achievement_rate

  validate :target_achievement_rate_within_range
  validates :target_score, presence: true
  validates :target_preparation_time_minutes, presence: true

  def display_preparation_time
    hours = target_preparation_time_minutes / 60
    minutes = target_preparation_time_minutes % 60
    "#{hours}時間#{minutes}分"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "max_score_id", "student_id", "subject_id", "target_achievement_rate", "target_preparation_time_minutes", "target_score", "test_name_id", "updated_at"]
  end

  private

  def calculate_target_achievement_rate
    return if target_score.nil? || max_score.nil?

    max_score_value = max_score.max_score
    self.target_achievement_rate = ((target_score.to_f / max_score_value) * 100).round
  end

  def target_achievement_rate_within_range
    if target_score.present? && max_score.present?
      calculated_target_achievement_rate = ((target_score.to_f / max_score.max_score) * 100).round
      if calculated_target_achievement_rate > 100
        errors.add(:target_score, "達成率は100%を超えることはできません")
      end
    end
  end
end
