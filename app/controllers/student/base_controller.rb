class Student::BaseController < ApplicationController
  before_action :check_student
  layout 'student/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to root_path
  end

  def check_student
    redirect_to new_student_session_path, warning: t('defaults.message.not_authorized') unless current_student
  end
end