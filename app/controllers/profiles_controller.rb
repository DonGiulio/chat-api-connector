class ProfilesController < ApplicationController
  after_action :authenticate!, only: %i[show]

  def index
    @q = Profile.ransack(params[:q])
    @profiles = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    session[:current_user] = params[:id]

    redirect_to chat_show_path
  end
end
