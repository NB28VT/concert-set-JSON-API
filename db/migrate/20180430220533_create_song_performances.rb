class CreateSongPerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :song_performances do |t|
      t.integer :position_id
      t.references :concert, foreign_key: true
      t.references :song, foreign_key: true
      t.references :set, foreign_key: true

      t.timestamps
    end
  end
end
