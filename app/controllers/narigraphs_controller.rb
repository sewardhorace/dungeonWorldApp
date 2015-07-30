class NarigraphsController < ApplicationController
  def index
    @narigraphs = Narigraph.all
    @narigraph = Narigraph.new
  end

  def new
    @narigraph = Narigraph.new
  end

  def create
    @narigraph = Narigraph.new(narigraph_params)

    if @narigraph.save
      redirect_to narigraphs_path
    else
      redirect_to narigraphs_path
    end
  end

  private
    def narigraph_params
      params.require(:narigraph).permit(:character_name, :text)
    end
end
