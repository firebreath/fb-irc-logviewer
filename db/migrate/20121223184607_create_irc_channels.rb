class CreateIrcChannels < ActiveRecord::Migration
  def up
    create_table :irc_channels do |t|
      t.string :name

      t.timestamps
    end
    add_index "irc_channels", :name
  end

  def down
    drop_table :irc_channels
  end

end
