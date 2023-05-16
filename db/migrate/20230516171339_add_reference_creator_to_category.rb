class AddReferenceCreatorToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :creator, foreign_key: { to_table: :users }
  end
end
