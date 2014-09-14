class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :subject
      t.string :content
      t.boolean :complete

      t.timestamps
    end
  end
end
