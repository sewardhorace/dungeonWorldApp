class Narigraph < ActiveRecord::Base
  validates :character_name, presence: true
  self.per_page = 10
  def timestamp
    created_at.strftime('%b %d %l:%M')
  end
end
