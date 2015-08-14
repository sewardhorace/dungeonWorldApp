class Player < ActiveRecord::Base

  enum role: [:player, :game_master]

  belongs_to :user
  belongs_to :game

  has_many :characters
end
