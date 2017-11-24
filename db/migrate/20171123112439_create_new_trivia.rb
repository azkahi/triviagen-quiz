class CreateNewTrivia < ActiveRecord::Migration
  def change
    create_table :new_trivia do |t|
      t.text :content
      t.text :title

      t.timestamps null: false
    end
  end
end
