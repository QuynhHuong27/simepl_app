class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = t "micropost.message.success"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
     # @feed_items = Micropost.feed(current_user).order_post.page(params[:page]).per Settings.panigate.users
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end

end
