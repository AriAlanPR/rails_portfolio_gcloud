class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.string :city
      t.string :weather
      t.string :description

      t.timestamps
    end
  end
end
