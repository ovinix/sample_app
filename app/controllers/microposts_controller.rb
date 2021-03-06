class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash.now[:success] = "Micropost created!"     
      @micropost = current_user.microposts.build
    end
    
    @feed_items = current_user.feed.paginate(page: params[:page])

    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
