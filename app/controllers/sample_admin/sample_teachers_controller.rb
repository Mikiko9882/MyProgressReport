class SampleAdmin::SampleTeachersController < SampleAdmin::BaseController
  before_action :set_sample_school
  before_action :set_sample_teacher, only: [:show]

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sample_school
    @sample_school = SampleSchool.find(params[:sample_school_id])
  end

  def set_sample_teacher
    @sample_teacher = @sample_school.sample_teachers.find(params[:code])
  end

  # Only allow a list of trusted parameters through.
  def sample_teacher_params
    params.require(:sample_teacher).permit(:name, :login_id, :password, :password_confirmation)
  end
end
