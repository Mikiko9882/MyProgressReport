class SampleAdmin::SampleStudentClassesController < SampleAdmin::BaseController
  before_action :set_sample_school
  before_action :set_sample_student_class, only: [:show, :edit, :update, :destroy]

  # 新しいクラスを作成するためのフォームを表示するアクション
  def new
    @sample_student_class = @sample_school.sample_student_classes.build
  end

  # 新しいクラスを作成するアクション
  def create
    @sample_student_class = @sample_school.sample_student_classes.build(sample_student_class_params)
    if @sample_student_class.save
      redirect_to sample_admin_sample_school_path(@sample_school), success: t('defaults.message.created', item: StudentClass.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: StudentClass.model_name.human)
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
    if @sample_student_class.update(sample_student_class_params)
      redirect_to sample_admin_sample_school_path(@sample_school), success: t('defaults.message.updated', item: StudentClass.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: StudentClass.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # クラスを削除するアクション
  def destroy
    @sample_student_class.destroy!
    redirect_to sample_admin_sample_school_path(@sample_school), success: t('defaults.message.deleted', item: StudentClass.model_name.human)
  end

  private

  def set_sample_school
    @sample_school = SampleSchool.find(params[:sample_school_id])
  end

  # 特定の学生クラスを設定する
  def set_sample_student_class
    @sample_student_class = @sample_school.sample_student_classes.find(params[:sample_school_id])
  end

  # 学生クラスのパラメータを許可する
  def sample_student_class_params
    params.require(:sample_student_class).permit(:name, :description)
  end
end
