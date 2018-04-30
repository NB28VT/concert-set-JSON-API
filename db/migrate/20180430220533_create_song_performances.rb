class CreateSongPerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :song_performances do |t|
      t.integer :position_id
      t.references :song, foreign_key: true
      t.references :concert_set, foreign_key: true

      t.timestamps
    end
  end
end
