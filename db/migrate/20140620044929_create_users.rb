class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :screen_name
      t.string :url
      t.string :description
      t.string :profile_image_url
      t.string :profile_banner_url
       
      t.timestamps
    end
  end
end
