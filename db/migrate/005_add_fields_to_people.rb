class AddFieldsToPeople < ActiveRecord::Migration
  def change
  	add_column :people, :favourite_language, :string
  	add_column :people, :years_experience, :integer
  	add_column :people, :favourite_meal, :string
  	add_column :people, :position, :string
  	add_column :people, :table_tennis_ladder, :integer
  end
end
