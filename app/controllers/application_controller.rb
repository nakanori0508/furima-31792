class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # deviseによる新規登録のみ、デフォルトではemailとパスワードのカラムしか保存を許可していない。許可するカラムを追加する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:lastname,:firstname,:lastname_kana,:firstname_kana,:birthday])
  end
end
