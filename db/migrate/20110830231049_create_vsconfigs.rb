class CreateVsconfigs < ActiveRecord::Migration
  def change
    create_table :vsconfigs do |t|
      t.string :title
      t.string :subdomain
      t.string :resume
      t.string :table_name
      t.datetime :date_begin
      t.string :stylesheet
      t.string :author
      t.text :description_left
      t.text :description_right
      t.string :favicon
      t.string :twitter_account
      t.string :html5_font
      t.string :idhv1
      t.boolean :advertisement
      t.boolean :ajax_load
      t.boolean :anonymous_vote
      t.boolean :user_reputation

      t.timestamps
    end
  end
end
