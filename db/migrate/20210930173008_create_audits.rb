class CreateAudits < ActiveRecord::Migration[6.1]
  def change
    create_table :audits do |t|
      t.references :auditable, polymorphic: true, null: false
      t.json :content
      t.string :responsible_user
      t.string :action

      t.timestamps
    end
  end
end
