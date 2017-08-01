class AddIsHiddenToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :is_hidden, :boolean, default: true
  end
end
