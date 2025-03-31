class CreateJoinTableUsersViewingParties < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :viewing_parties do |t|
      t.index :user_id
      t.index :viewing_party_id
    end
  end
end
