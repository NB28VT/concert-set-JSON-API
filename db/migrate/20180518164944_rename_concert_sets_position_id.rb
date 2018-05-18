class RenameConcertSetsPositionId < ActiveRecord::Migration[5.0]
  def change
    rename_column :concert_sets, :position_id, :set_number
  end
end
