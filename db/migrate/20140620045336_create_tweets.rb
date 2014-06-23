class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user
      t.string :text
      t.datetime :time

      t.timestamps
    end
  end
end
