class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :organization, index: true
      t.string :name

      t.timestamps null: false
    end
  end
end
