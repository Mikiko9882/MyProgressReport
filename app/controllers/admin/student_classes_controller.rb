class Admin::StudentClassesController < Admin::BaseController
  before_action :set_school
  before_action :set_student_class, only: [:show, :edit, :update, :destroy]

  # 新しいクラスを作成するためのフォームを表示するアクション
  def new
    @student_class = @school.student_classes.build
  end

  # 新しいクラスを作成するアクション
  def create
    @student_class = @school.student_classes.build(student_class_params)
    if @student_class.save
      redirect_to admin_school_path(@school), success: t('defaults.message.created', item: StudentClass.model_name.human)
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
    if @student_class.update(student_class_params)
      redirect_to admin_school_path(@school), success: t('defaults.message.updated', item: StudentClass.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: StudentClass.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  # クラスを削除するアクション
  def destroy
    @student_class.destroy!
    redirect_to admin_school_path(@school), success: t('defaults.message.deleted', item: StudentClass.model_name.human)
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  # 特定の学生クラスを設定する
  def set_student_class
    @student_class = @school.student_classes.find(params[:code])
  end

  # 学生クラスのパラメータを許可する
  def student_class_params
    params.require(:student_class).permit(:name, :description)
  end
end
