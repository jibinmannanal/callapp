class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.belongs_to :organization, index: true
      t.belongs_to :client, index: true
      t.belongs_to :contact, index: true
      t.timestamps null: false
    end

  end
end
