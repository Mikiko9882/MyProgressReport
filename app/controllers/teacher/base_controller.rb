class Teacher::BaseController < ApplicationController
  before_action :check_teacher
  layout 'teacher/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to root_path
  end

  def check_teacher
    redirect_to new_teacher_teacher_session_path, warning: t('defaults.message.not_authorized') unless current_teacher_teacher
  end
end