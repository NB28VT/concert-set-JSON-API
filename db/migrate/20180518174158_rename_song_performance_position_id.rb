class RenameSongPerformancePositionId < ActiveRecord::Migration[5.0]
  def change
    rename_column :song_performances, :position_id, :set_position
  end
end
