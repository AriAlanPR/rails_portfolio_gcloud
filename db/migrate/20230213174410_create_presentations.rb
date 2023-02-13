class CreatePresentations < ActiveRecord::Migration[7.0]
  def change
    create_table :presentations do |t|
      t.string :title
      t.string :subtitle
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
