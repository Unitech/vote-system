class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.references :user
      t.references :article
      t.timestamps
    end
  end
end
