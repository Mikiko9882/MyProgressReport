class Teacher::MaxScoresController < Teacher::BaseController
  before_action :set_max_score, only: [:show, :edit, :update, :destroy]


  # 新しいsubjectを作成するためのフォームを表示するアクション
  def new
    @max_score = current_teacher_teacher.max_scores.build
  end

  # 新しいsubjectを作成するアクション
  def create
    @max_score = current_teacher_teacher.max_scores.build(max_score_params)
    if @max_score.save
      redirect_to teacher_subjects_path, success: t('defaults.message.created', item: MaxScore.model_name.human)
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
    if @max_score.update(max_score_params)
      redirect_to teacher_max_score_path(@max_score), success: t('defaults.message.updated', item: MaxScore.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: MaxScore.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # subjectを削除するアクション
  def destroy
    @max_score.destroy!
    redirect_to teacher_subjects_path, success: t('defaults.message.deleted', item: MaxScore.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_max_score
    @max_score = current_teacher_teacher.max_scores.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def max_score_params
    params.require(:max_score).permit(:max_score)
  end
end
