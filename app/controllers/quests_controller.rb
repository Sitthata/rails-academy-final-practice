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

  def update
    @quest = Quest.find(params[:id])
    respond_to do |format|
      @quest.update(quest_params)
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@quest, partial: "quests/quest", locals: { quest: @quest })
      end
    end
  end

  def destroy
    @quest = Quest.find(params[:id]).destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@quest)
      end
    end
  end

  private
  def quest_params
    params.require(:quest).permit(:name, :completed, :id)
  end
end
