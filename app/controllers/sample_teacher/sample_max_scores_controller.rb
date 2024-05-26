class SampleTeacher::SampleMaxScoresController < SampleTeacher::BaseController
  
  # subjectの詳細を表示するアクション
  def show
    @sample_max_score = current_sample_teacher_sample_teacher.sample_max_scores.find(params[:id])
  end

  private

  # Only allow a list of trusted parameters through.
  def sample_max_score_params
    params.require(:sample_max_score).permit(:max_score)
  end
end
