class CreateFacebookUsers < ActiveRecord::Migration
  def change
    create_table :facebook_users do |t|
      t.string :name, null: false
      t.string :app_profile_id
      t.boolean :my_friend
      t.datetime :last_login

      t.timestamps
    end
  end
end
