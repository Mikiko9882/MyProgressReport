class SampleTeacher::SampleSubjectsController < SampleTeacher::BaseController
  before_action :set_sample_subject, only: [:show, :edit, :update, :destroy]

  def index
    @sample_subjects = current_sample_teacher_sample_teacher.sample_subjects
    @sample_test_names = current_sample_teacher_sample_teacher.sample_test_names
    @sample_max_scores = current_sample_teacher_sample_teacher.sample_max_scores
  end

  # 新しいsubjectを作成するためのフォームを表示するアクション
  def new
    @sample_subject = current_sample_teacher_sample_teacher.sample_subjects.build
  end

  # 新しいsubjectを作成するアクション
  def create
    @sample_subject = current_sample_teacher_sample_teacher.sample_subjects.build(sample_subject_params)
    if @sample_subject.save
      redirect_to sample_teacher_sample_subjects_path, success: t('defaults.message.created', item: Subject.model_name.human)
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
    if @sample_subject.update(sample_subject_params)
      redirect_to sample_teacher_sample_subject_path(@sample_subject), success: t('defaults.message.updated', item: Subject.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Subject.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # subjectを削除するアクション
  def destroy
    @sample_subject.destroy!
    redirect_to sample_teacher_sample_subjects_path, success: t('defaults.message.deleted', item: Subject.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sample_subject
    @sample_subject = current_sample_teacher_sample_teacher.sample_subjects.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sample_subject_params
    params.require(:sample_subject).permit(:subject_name)
  end
end
