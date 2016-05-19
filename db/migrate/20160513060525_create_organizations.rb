class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|

      t.string :organization_name
      t.text :address

      t.timestamps null: false
    end
  end
end
