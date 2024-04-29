class Teacher::StudentsController < Teacher::BaseController
  before_action :set_student, only: %i[edit update show destroy]
  
  def index
    @q = current_teacher_teacher.school.students.ransack(params[:q])
    @students = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end


  def edit; end

  def update
    if @student.update(student_params)
      redirect_to teacher_student_path(@student), success: t('defaults.message.updated', item: Student.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Student.model_name.human)
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @average_achievement_rate = @student.average_achievement_rate
  end

  def destroy
    @student.destroy!
    redirect_to teacher_students_path, success: t('defaults.message.deleted', item: Student.model_name.human)
  end
  
  private

  def set_student
    @student = Student.find(params[:id])
  end
  
  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation, :name, :grade_id, :student_class_id, :school_id )
  end
end
