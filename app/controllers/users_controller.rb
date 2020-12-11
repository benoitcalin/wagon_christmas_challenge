class UsersController < ApplicationController

  def new
    @user = User.new
    begin_date = (ENV["BEGIN_DATE"] || 11).to_i
    @day_range = (begin_date..25)
  end

  def create
    @user = User.new(user_params)
    @user.batch = Batch.find(params[:user][:batch]) if params[:user][:batch] != ""
    if @user.save
      redirect_to root_path, notice: "Ta participation a bien été prise en compte 👍"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:pseudo, :challenger_id)
  end
end
