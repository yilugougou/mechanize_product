class CreateMeDemos < ActiveRecord::Migration[6.0]
  def change
    create_table :me_demos do |t|
      t.string :me_text

      t.timestamps
    end
  end
end
