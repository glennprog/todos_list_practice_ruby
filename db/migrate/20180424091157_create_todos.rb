class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :notes
      t.date :deadline
      t.time :time

      t.timestamps
    end
  end
end
