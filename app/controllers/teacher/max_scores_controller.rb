class Teacher::MaxScoresController < Teacher::BaseController
  before_action :set_add_test
  before_action :set_max_score, only: [:show, :edit, :update, :destroy]

  # 新しいクラスを作成するためのフォームを表示するアクション
  def new
    @max_score = @add_test.max_scores.build
  end

  # 新しいクラスを作成するアクション
  def create
    @max_score = @add_test.max_scores.build(max_score_params)
    if @max_score.save
      redirect_to teacher_add_test_path(@add_test), success: t('defaults.message.created', item: MaxScore.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: MaxScore.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # クラスの詳細を表示するアクション
  def show
  end

  # クラスを編集するためのフォームを表示するアクション
  def edit
  end

  # クラスを更新するアクション
  def update
    if @max_score.update(max_score_params)
      redirect_to teacher_add_test_path_path(@add_test), success: t('defaults.message.updated', item: MaxScore.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: MaxScore.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # クラスを削除するアクション
  def destroy
    @max_score.destroy!
    redirect_to teacher_add_test_path(@add_test), success: t('defaults.message.deleted', item: MaxScore.model_name.human)
  end

  private

  def set_add_test
    @add_test = current_teacher.add_tests.find_by(params[:code])
  end

  def set_max_score
    @max_score = @add_test.max_scores.find(params[:id])
  end

  def max_score_params
    params.require(:max_score).permit(:max_score)
  end
end
