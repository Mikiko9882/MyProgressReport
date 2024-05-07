class Student::ComparisonsController < Student::BaseController
  def index
    @targets_and_results = []
    current_student.targets.each do |target|
      test_result = current_student.test_results.find_by(test_name_id: target.test_name_id, subject_id: target.subject_id)
      if test_result
        comparison = {
          target: target,
          test_result: test_result,
          score_comparison: test_result.score >= target.target_score,
          preparation_time_comparison: test_result.preparation_time_minutes >= target.target_preparation_time_minutes,
          achievement_rate_comparison: test_result.achievement_rate >= target.target_achievement_rate
        }
        @targets_and_results << comparison
      end
    end
  end
end
