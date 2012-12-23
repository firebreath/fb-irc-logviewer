class CreateLogEntries < ActiveRecord::Migration
  def up
    create_table :log_entries do |t|
      t.integer :log_file_id
      t.timestamp :when
      t.string :who
      t.string :what

      t.timestamps
    end

    execute "alter table log_entries add constraint fk_log_entries_log_file_id foreign key (log_file_id) references log_files(id)"
  end

  def down
    drop_table :log_entries
  end
end
