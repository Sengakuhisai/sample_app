class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    @micropost=current_user.microposts.build(micropost_params)
    if @micropost.content.index("@")!=nil && reply_name!=nil
      @micropost[:in_reply_to]=reply_name
      @micropost.save
      flash[:success]="Sent reply"
      redirect_to root_url
    elsif @micropost.save
      flash[:success]="Micopost created!"
      redirect_to root_url
    else
      @feed_items=[]
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success]="Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    def correct_user
      @micropost=current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
    
    def reply_name
      all_users=User.select("name")
      all_users.each do |user|
        if rep=@micropost.content.match("@#{user.name}")
          rep[0]
          break
        end
      end
    end
end
