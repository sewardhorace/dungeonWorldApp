class UserGame < ActiveRecord::Base

  after_create :create_player

  belongs_to :game
  belongs_to :user

  private

  def create_player
    
  end

end
