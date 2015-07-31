class NarigraphsController < ApplicationController
  def index
    @narigraphs = Narigraph.order('created_at ASC')
    @narigraph = Narigraph.new
  end

  def create
    respond_to do |format|
      @narigraph = Narigraph.new(narigraph_params)
      if @narigraph.save
        flash[:success] = 'successfil'
      else
        flash[:error] = 'nope erer'
      end
      format.html {redirect_to narigraphs_path}
      format.js
    end
  end

  private
    def narigraph_params
      params.require(:narigraph).permit(:character_name, :text)
    end
end
