class AddImportantAndExecutiveToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :important_class, :string
    add_column :events, :executive_method, :string
  end
end
