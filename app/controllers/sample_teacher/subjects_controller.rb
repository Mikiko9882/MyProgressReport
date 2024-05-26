class Teacher::SubjectsController < Teacher::BaseController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    @subjects = current_teacher_teacher.subjects
    @test_names = current_teacher_teacher.test_names
    @max_scores = current_teacher_teacher.max_scores
  end

  # 新しいsubjectを作成するためのフォームを表示するアクション
  def new
    @subject = current_teacher_teacher.subjects.build
  end

  # 新しいsubjectを作成するアクション
  def create
    @subject = current_teacher_teacher.subjects.build(subject_params)
    if @subject.save
      redirect_to teacher_subjects_path, success: t('defaults.message.created', item: Subject.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Subject.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # subjectの詳細を表示するアクション
  def show
  end

  # subjectを編集するためのフォームを表示するアクション
  def edit
  end

  # subjectを更新するアクション
  def update
    if @subject.update(subject_params)
      redirect_to teacher_subject_path(@subject), success: t('defaults.message.updated', item: Subject.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Subject.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # subjectを削除するアクション
  def destroy
    @subject.destroy!
    redirect_to teacher_subjects_path, success: t('defaults.message.deleted', item: Subject.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subject
    @subject = current_teacher_teacher.subjects.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subject_params
    params.require(:subject).permit(:subject_name)
  end
end
