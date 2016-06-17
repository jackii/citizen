module CitizenBudgetModel
  class Sensitivity < ActiveRecord::Base
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :organization
    has_many :variables, -> { order(:position) }, dependent: :destroy
    has_many :sensitivity_sections, -> { order(:position) }, dependent: :destroy

    validates_presence_of :organization_id
    validates :name, 'citizen_budget_model/locale' => true

    def to_handsontable

      @sensitivity = self
      @data = Array.new
      @sensitivities = Array.new
      @variables = Array.new
      @data << {variable_name:"Default Formula",
                pbo_assumption:@sensitivity.default_excel_formula,
                #url:sensitivity_path(@sensitivity),
                B:"default_formula",
                bold:[0]}
      @data << {}
      @sensitivity.sensitivity_sections.each do |s|
        @sensitivities << {sname: s.name,
                              E: '',
                              F: '',
                              G: '',
                              H: '',
                              year_1_excel_formula: 'Year 1',
                              year_1_formula: '',
                              year_2_excel_formula: 'Year 2',
                              year_2_formula: '',
                              year_5_excel_formula: 'Year 5',
                              year_5_formula: '',
                              impact_url: '',
                              bold:[5,6,7,8]
                            }
        s.impacts.each do |impact|
          @sensitivities << {sid: impact.id,
                                sname: impact.name,
                                E: impact.machine_name,
                                F: "#{impact.machine_name}_year_1",
                                G: "#{impact.machine_name}_year_2",
                                H: "#{impact.machine_name}_year_5",
                                year_1_excel_formula: impact.year_1_excel_formula,
                                year_1_formula: impact.year_1_formula,
                                year_2_excel_formula: impact.year_2_excel_formula,
                                year_2_formula: impact.year_2_formula,
                                year_5_excel_formula: impact.year_5_excel_formula,
                                year_5_formula: impact.year_5_formula,
                                #impact_url: sensitivity_sensitivity_section_impact_path(@sensitivity, s, impact),
                                bold:[5,6,7,8]
                              }
        end
        @sensitivities << {}
      end

      @variables << {variable_name: "Public Editable Variables", pbo_assumption:"PBO Assumption", user_input: "User Input"}
      @sensitivity.variables.where(public_editable: true).each do |v|
        @variables << {id: v.id,
                      variable_name:v.name,
                      B:"#{v.machine_name}_pbo_assumption",
                      pbo_assumption:v.pbo_assumption,
                      user_input:v.default_value,
                      C:"#{v.machine_name}_user_input",
                      #variable_url: sensitivity_variable_path(@sensitivity, v)
                      }
        end

      @variables << {}
      @variables << {variable_name: "Non Public Editable Variables", pbo_assumption:"PBO Assumption", user_input: ""}
      @sensitivity.variables.where(public_editable: false).each do |v|
        @variables << {id: v.id,
                       variable_name:v.name,
                       B:v.machine_name,
                       pbo_assumption:v.pbo_assumption,
                       user_input:'',
                       #variable_url: sensitivity_variable_path(@sensitivity, v)
                       }
      end

      if @sensitivities.size > @variables.size
        @sensitivities.each_with_index do |s, index|
          if @variables[index].blank?
            @data << s
          else
            @data << @variables[index].merge(s)
          end
        end
      else
        @variables.each_with_index do |v, index|
          if @sensitivities[index].blank?
            @data << v
          else
            @data << @sensitivities[index].merge(v)
          end
        end
      end
      @data
    end
  end
end
