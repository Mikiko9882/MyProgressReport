class SampleTeacher::SampleMaxScoresController < SampleTeacher::BaseController
  before_action :set_sample_max_score, only: [:show, :edit, :update, :destroy]

  # 新しいsubjectを作成するためのフォームを表示するアクション
  def new
    @sample_max_score = current_sample_teacher_sample_teacher.sample_max_scores.build
  end

  # 新しいsubjectを作成するアクション
  def create
    @sample_max_score = current_sample_teacher_sample_teacher.sample_max_scores.build(sample_max_score_params)
    if @sample_max_score.save
      redirect_to sample_teacher_sample_subjects_path, success: t('defaults.message.created', item: MaxScore.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: MaxScore.model_name.human)
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
    if @sample_max_score.update(sample_max_score_params)
      redirect_to sample_teacher_sample_max_score_path(@sample_max_score), success: t('defaults.message.updated', item: MaxScore.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: MaxScore.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # subjectを削除するアクション
  def destroy
    @sample_max_score.destroy!
    redirect_to sample_teacher_sample_subjects_path, success: t('defaults.message.deleted', item: MaxScore.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sample_max_score
    @sample_max_score = current_sample_teacher_sample_teacher.sample_max_scores.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sample_max_score_params
    params.require(:sample_max_score).permit(:max_score)
  end
end
