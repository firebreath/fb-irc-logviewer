class CreateLogEntries < ActiveRecord::Migration
  def up
    create_table :log_entries do |t|
      t.integer :log_file_id
      t.timestamp :when
      t.string :who
      t.text :what

      t.timestamps
    end

    add_index :log_entries, :log_file_id
    add_index :log_entries, [:who, :when, :what]

    # kxm: mysql specific
    # execute "alter table log_entries add constraint fk_log_entries_log_file_id foreign key (log_file_id) references log_files(id)"
  end

  def down
    drop_table :log_entries
  end
end
