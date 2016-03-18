class AddPopoverToPolicySection < ActiveRecord::Migration
  def up
    CitizenBudgetModel::PolicySection.add_translation_fields! popover: :text
  end

  def down
    remove_column :policy_section_translations, :popover
  end
end
