class CreateConcertSets < ActiveRecord::Migration[5.0]
  def change
    create_table :concert_sets do |t|
      t.integer :concert_id
      t.integer :position_id

      t.timestamps
    end
  end
end
