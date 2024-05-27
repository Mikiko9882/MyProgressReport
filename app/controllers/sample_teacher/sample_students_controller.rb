class SampleTeacher::SampleStudentsController < SampleTeacher::BaseController
  before_action :set_sample_student, only: %i[show]
  
  def index
    @q = current_sample_teacher_sample_teacher.sample_school.sample_students.ransack(params[:q])
    @sample_students = @q.result(distinct: true).order(created_at: :desc)
  end


  def show
    @average_achievement_rate = @sample_student.average_achievement_rate
  end
  
  private

  def set_sample_student
    @sample_student = SampleStudent.find(params[:id])
  end
  
  def sample_student_params
    params.require(:sample_student).permit(:student_number, :password, :password_confirmation, :name, :furigana, :grade_id, :sample_student_class_id, :sample_school_id )
  end
end
