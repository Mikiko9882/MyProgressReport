class SampleStudent::SampleComparisonsController < SampleStudent::BaseController
  def index
    @sample_targets_and_results = []
    current_sample_student_sample_student.sample_targets.each do |sample_target|
      sample_test_result = current_sample_student_sample_student.sample_test_results.find_by(sample_test_name_id: sample_target.sample_test_name_id, sample_subject_id: sample_target.sample_subject_id)
      if sample_test_result
        sample_comparison = {
          sample_target: sample_target,
          sample_test_result: sample_test_result,
          sample_score_comparison: sample_test_result.score >= sample_target.target_score,
          sample_preparation_time_comparison: sample_test_result.preparation_time_minutes >= sample_target.target_preparation_time_minutes,
          sample_achievement_rate_comparison: sample_test_result.achievement_rate >= sample_target.target_achievement_rate
        }
        @sample_targets_and_results << sample_comparison
      end
    end
  end
end
