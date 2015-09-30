class Narigraph < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :character
  belongs_to :game

  self.per_page = 10 #for pagination

  def timestamp
    created_at.strftime('%b %-d %l:%M')
  end

end
