class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :phone_number
      t.belongs_to :organization, index: true
      t.belongs_to :client, index: true
      t.timestamps null: false
    end

  end
end
