class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    @message = current_user.sends.build( msg_params )
    if @message.save
      flash[:success] = "A message is sent."
      redirect_to user_path(params[:message][:to_id])
    else
      flash[:danger] = "You missed to send."
      redirect_to user_path(params[:message][:to_id])
    end
  end
  
  def destroy
  end
  
  private
  
    def msg_params
      params.require(:message).permit(:content, :to_id)
    end
end
