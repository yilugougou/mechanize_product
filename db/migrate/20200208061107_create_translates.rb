class CreateTranslates < ActiveRecord::Migration[6.0]
  def change
    create_table :translates do |t|
      t.text :q
      t.text :text
      t.string :tl

      t.timestamps
    end
  end
end
