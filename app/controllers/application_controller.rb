class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_company_by_handle
    @company = Company.with_handle params[:handle]
    # 404?
  end

end
