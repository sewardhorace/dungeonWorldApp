class Narigraph < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :character
  belongs_to :game

  self.per_page = 10 #for pagination

  after_create :push

  def timestamp
    created_at.strftime('%b %-d %l:%M')
  end

  private
  def push
    Pusher['test_channel'].trigger('posted', {
      new_entry: self.as_json,
      character: self.character.as_json
    })
  end

end
