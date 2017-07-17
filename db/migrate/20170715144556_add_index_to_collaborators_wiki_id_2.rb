class AddIndexToCollaboratorsWikiId2 < ActiveRecord::Migration[5.0]
  def change
    add_index :collaborators, [:wiki_id, :user_id]
  end
end
