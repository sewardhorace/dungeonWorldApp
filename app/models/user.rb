class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  has_many :characters, dependent: :destroy
  def activeCharacter
    self.characters.first
  end
end
