class NarigraphsController < ApplicationController
  def index
    @narigraphs = Narigraph.all
  end

  def new
    @narigraph = Narigraph.new
  end

  def create
    @narigraph = Narigraph.new(narigraph_params)

    @narigraph.save
    redirect_to narigraphs_path
  end

  private
    def narigraph_params
      params.require(:narigraph).permit(:character_name, :text)
    end
end
