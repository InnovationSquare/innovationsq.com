class DocsController < ApplicationController

  before_filter :load_company_by_handle

  def index
    @title = "Documents | #{@company.name}"
    @docs = @company.docs.includes(:creator)
    setup_company @company
  end

end