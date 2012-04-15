class FollowController < ApplicationController
  
  def create
    @company = Company.with_handle params[:handle]
    if @company
      current_person.follow! @company
      redirect_to "/#{@company.handle}"
    else
      # fail
      redirect_to "/"
    end
  end
  
  def destroy
    @company = Company.with_handle params[:handle]
    if @company
      current_person.unfollow! @company
      redirect_to "/#{@company.handle}"
    else
      # fail
      redirect_to "/"
    end
  end
  
end