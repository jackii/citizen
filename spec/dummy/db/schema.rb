# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160615071325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "citizen_budget_model_economic_measure_translations", force: true do |t|
    t.integer  "citizen_budget_model_economic_measure_id",              null: false
    t.string   "locale",                                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                     default: "", null: false
    t.string   "unit_name",                                default: "", null: false
  end

  add_index "citizen_budget_model_economic_measure_translations", ["citizen_budget_model_economic_measure_id"], name: "index_9851213727b93f385136e45f84f98bb403597f85", using: :btree
  add_index "citizen_budget_model_economic_measure_translations", ["locale"], name: "index_citizen_budget_model_economic_measure_translations_on_loc", using: :btree

  create_table "citizen_budget_model_economic_measures", force: true do |t|
    t.integer  "policy_section_id"
    t.string   "machine_name"
    t.integer  "position"
    t.decimal  "year_1_value"
    t.decimal  "year_2_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
  end

  add_index "citizen_budget_model_economic_measures", ["policy_section_id"], name: "index_citizen_budget_model_economic_measures_on_policy_section_", using: :btree

  create_table "citizen_budget_model_impact_translations", force: true do |t|
    t.integer  "citizen_budget_model_impact_id",              null: false
    t.string   "locale",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                           default: "", null: false
  end

  add_index "citizen_budget_model_impact_translations", ["citizen_budget_model_impact_id"], name: "index_ce7f3b9c1df4be43327310f072a62739d1147223", using: :btree
  add_index "citizen_budget_model_impact_translations", ["locale"], name: "index_citizen_budget_model_impact_translations_on_locale", using: :btree

  create_table "citizen_budget_model_impact_variables", force: true do |t|
    t.integer  "impact_id"
    t.integer  "variable_id"
    t.string   "year"
    t.decimal  "coefficient"
    t.integer  "prepopulated_result", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "citizen_budget_model_impact_variables", ["impact_id"], name: "index_citizen_budget_model_impact_variables_on_impact_id", using: :btree

  create_table "citizen_budget_model_impacts", force: true do |t|
    t.integer  "sensitivity_section_id"
    t.string   "machine_name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "year_1_formula"
    t.text     "year_1_excel_formula"
    t.text     "year_2_formula"
    t.text     "year_2_excel_formula"
    t.text     "year_5_formula"
    t.text     "year_5_excel_formula"
    t.boolean  "is_public",              default: true
  end

  add_index "citizen_budget_model_impacts", ["sensitivity_section_id"], name: "index_citizen_budget_model_impacts_on_sensitivity_section_id", using: :btree

  create_table "citizen_budget_model_organization_translations", force: true do |t|
    t.integer  "citizen_budget_model_organization_id",              null: false
    t.string   "locale",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                 default: "", null: false
  end

  add_index "citizen_budget_model_organization_translations", ["citizen_budget_model_organization_id"], name: "index_c552302e912cf73047023f2dfc3372fbc32967d6", using: :btree
  add_index "citizen_budget_model_organization_translations", ["locale"], name: "index_citizen_budget_model_organization_translations_on_locale", using: :btree

  create_table "citizen_budget_model_organizations", force: true do |t|
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "citizen_budget_model_policy_section_translations", force: true do |t|
    t.integer  "citizen_budget_model_policy_section_id",              null: false
    t.string   "locale",                                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                   default: "", null: false
    t.text     "popover"
  end

  add_index "citizen_budget_model_policy_section_translations", ["citizen_budget_model_policy_section_id"], name: "index_8c9ad0923c2aee9395df3a70316e599b8d5fbc9e", using: :btree
  add_index "citizen_budget_model_policy_section_translations", ["locale"], name: "index_198992f7783970c5f018c608284882f0b768365b", using: :btree

  create_table "citizen_budget_model_policy_sections", force: true do |t|
    t.integer  "policy_table_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "citizen_budget_model_policy_sections", ["policy_table_id"], name: "index_citizen_budget_model_policy_sections_on_policy_table_id", using: :btree

  create_table "citizen_budget_model_policy_table_translations", force: true do |t|
    t.integer  "citizen_budget_model_policy_table_id",              null: false
    t.string   "locale",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                 default: "", null: false
  end

  add_index "citizen_budget_model_policy_table_translations", ["citizen_budget_model_policy_table_id"], name: "index_8b0e5f51f77b4a8bef104953c45518571935ccec", using: :btree
  add_index "citizen_budget_model_policy_table_translations", ["locale"], name: "index_citizen_budget_model_policy_table_translations_on_locale", using: :btree

  create_table "citizen_budget_model_policy_tables", force: true do |t|
    t.integer  "organization_id"
    t.decimal  "growth_forecast"
    t.decimal  "employment_coefficient"
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "simulator_id"
  end

  create_table "citizen_budget_model_question_translations", force: true do |t|
    t.integer  "citizen_budget_model_question_id",              null: false
    t.string   "locale",                                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                             default: "", null: false
    t.text     "title",                            default: "", null: false
    t.text     "description",                      default: "", null: false
    t.text     "modal",                            default: "", null: false
    t.text     "popover",                          default: "", null: false
    t.string   "labels",                           default: [], null: false, array: true
    t.string   "unit_name",                        default: "", null: false
    t.string   "placeholder",                      default: "", null: false
  end

  add_index "citizen_budget_model_question_translations", ["citizen_budget_model_question_id"], name: "index_6f66eb2c3052d6e00221297d74a882e67880fdba", using: :btree
  add_index "citizen_budget_model_question_translations", ["locale"], name: "index_citizen_budget_model_question_translations_on_locale", using: :btree

  create_table "citizen_budget_model_questions", force: true do |t|
    t.integer  "section_id"
    t.string   "machine_name",    default: "",    null: false
    t.float    "default_value"
    t.float    "unit_value_down"
    t.string   "account",         default: "",    null: false
    t.string   "widget",          default: "",    null: false
    t.float    "options",         default: [],    null: false, array: true
    t.boolean  "revenue",         default: false
    t.integer  "maxlength"
    t.boolean  "required",        default: false
    t.integer  "rows"
    t.integer  "cols"
    t.integer  "size"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "html_class",      default: "",    null: false
    t.float    "unit_value_up"
  end

  add_index "citizen_budget_model_questions", ["section_id"], name: "index_citizen_budget_model_questions_on_section_id", using: :btree

  create_table "citizen_budget_model_section_translations", force: true do |t|
    t.integer  "citizen_budget_model_section_id",              null: false
    t.string   "locale",                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                           default: "", null: false
    t.text     "description",                     default: "", null: false
    t.text     "modal",                           default: "", null: false
    t.text     "popover",                         default: "", null: false
  end

  add_index "citizen_budget_model_section_translations", ["citizen_budget_model_section_id"], name: "index_2b79c59d2a47f33d3e927dae21105b97719ec5c0", using: :btree
  add_index "citizen_budget_model_section_translations", ["locale"], name: "index_citizen_budget_model_section_translations_on_locale", using: :btree

  create_table "citizen_budget_model_sections", force: true do |t|
    t.integer  "simulator_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "html_class",   default: "", null: false
  end

  add_index "citizen_budget_model_sections", ["simulator_id"], name: "index_citizen_budget_model_sections_on_simulator_id", using: :btree

  create_table "citizen_budget_model_sensitivities", force: true do |t|
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "default_formula"
    t.text     "default_excel_formula"
  end

  create_table "citizen_budget_model_sensitivity_section_translations", force: true do |t|
    t.integer  "citizen_budget_model_sensitivity_section_id",              null: false
    t.string   "locale",                                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                        default: "", null: false
  end

  add_index "citizen_budget_model_sensitivity_section_translations", ["citizen_budget_model_sensitivity_section_id"], name: "index_df424d9422571b7f7d41889fde517ad3fcf3af9d", using: :btree
  add_index "citizen_budget_model_sensitivity_section_translations", ["locale"], name: "index_519abc180d7f736f84ae6fc1b9ae2efb31eed0d4", using: :btree

  create_table "citizen_budget_model_sensitivity_sections", force: true do |t|
    t.integer  "sensitivity_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_expenses",    default: false
  end

  add_index "citizen_budget_model_sensitivity_sections", ["sensitivity_id"], name: "index_citizen_budget_model_sensitivity_sections_sensitivity_id", using: :btree

  create_table "citizen_budget_model_sensitivity_translations", force: true do |t|
    t.integer  "citizen_budget_model_sensitivity_id",              null: false
    t.string   "locale",                                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                default: "", null: false
  end

  add_index "citizen_budget_model_sensitivity_translations", ["citizen_budget_model_sensitivity_id"], name: "index_9ecc315db3cfa14183fa72c234ca60d36fa0d210", using: :btree
  add_index "citizen_budget_model_sensitivity_translations", ["locale"], name: "index_citizen_budget_model_sensitivity_translations_on_locale", using: :btree

  create_table "citizen_budget_model_simulator_translations", force: true do |t|
    t.integer  "citizen_budget_model_simulator_id",              null: false
    t.string   "locale",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                              default: "", null: false
  end

  add_index "citizen_budget_model_simulator_translations", ["citizen_budget_model_simulator_id"], name: "index_b5903b0d0fd09cf4e469b0fadf1c02d7a8b9e95f", using: :btree
  add_index "citizen_budget_model_simulator_translations", ["locale"], name: "index_citizen_budget_model_simulator_translations_on_locale", using: :btree

  create_table "citizen_budget_model_simulators", force: true do |t|
    t.integer  "organization_id"
    t.string   "equation",                  default: "",    null: false
    t.string   "distribution",              default: "",    null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                    default: false
    t.integer  "total_revenue",   limit: 8
  end

  add_index "citizen_budget_model_simulators", ["organization_id"], name: "index_citizen_budget_model_simulators_on_organization_id", using: :btree

  create_table "citizen_budget_model_users", force: true do |t|
    t.integer  "organization_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "citizen_budget_model_users", ["email"], name: "index_citizen_budget_model_users_on_email", unique: true, using: :btree
  add_index "citizen_budget_model_users", ["organization_id"], name: "index_citizen_budget_model_users_on_organization_id", using: :btree
  add_index "citizen_budget_model_users", ["reset_password_token"], name: "index_citizen_budget_model_users_on_reset_password_token", unique: true, using: :btree

  create_table "citizen_budget_model_variable_translations", force: true do |t|
    t.integer  "citizen_budget_model_variable_id",              null: false
    t.string   "locale",                                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                             default: "", null: false
    t.string   "unit_name",                        default: "", null: false
  end

  add_index "citizen_budget_model_variable_translations", ["citizen_budget_model_variable_id"], name: "index_2f9b41f8d6e4c04b526d9b0e1887359dfd222261", using: :btree
  add_index "citizen_budget_model_variable_translations", ["locale"], name: "index_citizen_budget_model_variable_translations_on_locale", using: :btree

  create_table "citizen_budget_model_variables", force: true do |t|
    t.integer  "sensitivity_id"
    t.string   "machine_name"
    t.decimal  "default_value"
    t.decimal  "maximum"
    t.decimal  "minimum"
    t.decimal  "step"
    t.integer  "position"
    t.decimal  "pbo_assumption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_editable", default: true
  end

  add_index "citizen_budget_model_variables", ["sensitivity_id"], name: "index_citizen_budget_model_variables_on_sensitivity_id", using: :btree

  create_table "thing_translations", force: true do |t|
    t.integer  "thing_id",                null: false
    t.string   "locale",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       default: "", null: false
  end

  add_index "thing_translations", ["locale"], name: "index_thing_translations_on_locale", using: :btree
  add_index "thing_translations", ["thing_id"], name: "index_thing_translations_on_thing_id", using: :btree

  create_table "things", force: true do |t|
  end

end
