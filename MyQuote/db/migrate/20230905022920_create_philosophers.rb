class CreatePhilosophers < ActiveRecord::Migration[7.0]
  def change
    create_table :philosophers do |t|
      t.string :pfname, null: false
      t.string :plname, null: false
      t.date :pdob, null: false
      t.date :pdod, null: true
      t.text :pbiography, null: true

      t.timestamps
    end
  end
end
