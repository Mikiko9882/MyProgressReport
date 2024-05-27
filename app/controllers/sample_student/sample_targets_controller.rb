class SampleStudent::SampleTargetsController < SampleStudent::BaseController
  
  def index
    @q = current_sample_student_sample_student.sample_targets.ransack(params[:q])
    @sample_targets = @q.result.order(created_at: :desc)
  end
  
  private
  
  def target_params
    params.require(:sample_target).permit(:sample_test_name_id, :target_score, :sample_max_score_id, :target_preparation_time_minutes, :sample_subject_id)
  end
end
