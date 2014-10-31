class CreateGcals < ActiveRecord::Migration
  def change
    create_table :gcals do |t|
      t.integer :project_id
      t.string :subject
      t.text :description
    end
  end
end
