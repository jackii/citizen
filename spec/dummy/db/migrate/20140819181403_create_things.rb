class CreateThings < ActiveRecord::Migration
  def up
    create_table :things do |t|
    end
    Thing.create_translation_table!({
      name: {type: :string, null: false, default: ''},
    })
  end

  def down
    drop_table :things
    Thing.drop_translation_table!
  end
end
