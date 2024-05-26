class SampleTeacher::SampleSubjectsController < SampleTeacher::BaseController

  def index
    @sample_subjects = current_sample_teacher_sample_teacher.sample_subjects
    @sample_test_names = current_sample_teacher_sample_teacher.sample_test_names
    @sample_max_scores = current_sample_teacher_sample_teacher.sample_max_scores
  end

  # subjectの詳細を表示するアクション
  def show
    @sample_subject = current_sample_teacher_sample_teacher.sample_subjects.find(params[:id])
  end

  private

  # Only allow a list of trusted parameters through.
  def sample_subject_params
    params.require(:sample_subject).permit(:subject_name)
  end
end
