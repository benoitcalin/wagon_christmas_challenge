class UsersController < ApplicationController

  def self.update_score
    scores = GetResultsService.call
    scores.each do |challenger_id, score|
      user = User.find_by_challenger_id(challenger_id)
      user.update(score: score) if user
    end
  end

  def new
    @user = User.new
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
