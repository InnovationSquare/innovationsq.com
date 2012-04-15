class RecommendationsController < ApplicationController
  
  def create
    @company = Company.with_handle params[:handle]
    if @company
      current_person.recommend! @company
      redirect_to "/#{@company.handle}"
    else
      # fail
      redirect_to "/"
    end
  end
  
  def destroy
    @company = Company.with_handle params[:handle]
    if @company
      current_person.unrecommend! @company
      redirect_to "/#{@company.handle}"
    else
      # fail
      redirect_to "/"
    end
  end
  
end