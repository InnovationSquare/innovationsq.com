class DocsController < ApplicationController

  before_filter :load_company_by_handle

  def index
    @title = "Documents | #{@company.name}"
    @docs = @company.docs.desc(:created_at).includes(:creator)
    setup_company @company
  end

  def show
    @doc = Doc.with_id params[:id]
    @company = @doc.company
    setup_company @company
    @title = "#{@doc.title} | #{@company.name}"
  end

end