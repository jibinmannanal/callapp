class AddVerifiedToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :verified, :boolean ,default: false
  end
end
