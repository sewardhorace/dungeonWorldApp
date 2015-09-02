class AddIsPartyMemberToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :is_party_member, :boolean, default: false
  end
end
