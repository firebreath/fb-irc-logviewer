class CreateLogFiles < ActiveRecord::Migration
  def up
    create_table :log_files do |t|
      t.integer :irc_channel_id
      t.string :file_name
      t.date :file_date

      t.timestamps
    end

    add_index :log_files, :irc_channel_id

    # kxm: mysql specific
    #execute "alter table log_files add constraint fk_log_files_irc_channel_id foreign key (irc_channel_id) references irc_channels(id)"
  end

  def down
    drop_table :log_files
  end
end
