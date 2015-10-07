# class Player < ActiveRecord::Base
#
#   enum role: [:player, :game_master]
#
#   belongs_to :user
#   belongs_to :game
#
#   has_many :characters
#
#   def active_character
#     characters.where(is_active: true).first
#   end
#
#   def active_party_member
#     characters.where(is_party_member: true).first
#   end
#
#   def is_active
#     self.user.is_active
#   end
# end
