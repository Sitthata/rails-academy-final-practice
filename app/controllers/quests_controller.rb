class QuestsController < ApplicationController
  def index
    @quests = Quest.order(created_at: :desc)
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)
    if @quest.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @quest = Quest.find(params[:id]).destroy!
  end

  private
  def quest_params
    params.require(:quest).permit(:name, :completed, :id)
  end
end
