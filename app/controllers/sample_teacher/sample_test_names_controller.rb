class SampleTeacher::SampleTestNamesController < SampleTeacher::BaseController

  def show
    @sample_test_name = current_sample_teacher_sample_teacher.sample_test_names.find(params[:id])
  end

  private

  def sample_test_name_params
    params.require(:sample_test_name).permit(:test_name)
  end
end
