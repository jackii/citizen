module CitizenBudgetModel
  module AdminHelper
    # Formats as a percentage if the unit name is "%", as a currency if the unit
    # name is "$" and as a number otherwise.
    def value_formatter(question, options = {})
      if question.unit_name == '%'
        percentage_formatter(options)
      elsif question.unit_name == '$'
        currency_formatter(options)
      else
        precision_formatter(options.merge(:unit => question.unit_name))
      end
    end

    def percentage_formatter(options = {})
      lambda{|v|
        number_to_percentage(v, {strip_insignificant_zeros: true}.merge(options))
      }
    end

    def currency_formatter(options = {})
      lambda{|v|
        number_to_currency(v, {strip_insignificant_zeros: true}.merge(options))
      }
    end

    def precision_formatter(options = {})
      lambda{|v|
        number_with_precision(v, {strip_insignificant_zeros: true}.merge(options)) + options[:unit] + ' '
      }
    end

    # Returns whether any of the given attributes are not hidden fields.
    #
    # @param record
    # @param attributes
    # @return [Boolean] whether any of the given attributes are not hidden fields
    # @see CitizenBudgetModel.hidden_fields
    def visible?(record, *attributes)
      attributes.any? do |attribute|
        !CitizenBudgetModel.hidden_fields.fetch(record.class.model_name.param_key.to_sym, []).include?(attribute)
      end
    end

    # Returns whether any of the given attributes are present.
    #
    # @param record
    # @param attributes
    # @return [Boolean] whether any of the given attributes are present
    def present?(record, *attributes)
      attributes.any? do |attribute|
        record[attribute].present?
      end
    end

    def to_handsontable(sensitivity)

      @sensitivity = sensitivity
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
                              bold:[4,5,6,7]
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
                                impact_url: sensitivity_sensitivity_section_impact_path(@sensitivity, s, impact),
                              }
        end
        @sensitivities << {}
      end

      @variables << {variable_name: "Public Editable Variables", pbo_assumption:"PBO Assumption", user_input: "User Input", bold:[0,1,2]}
      @sensitivity.variables.where(public_editable: true).each do |v|
        @variables << {id: v.id,
                      variable_name:v.name,
                      B:"#{v.machine_name}_pbo_assumption",
                      pbo_assumption:v.pbo_assumption,
                      user_input:v.default_value,
                      C:"#{v.machine_name}_user_input",
                      variable_url: sensitivity_variable_path(@sensitivity, v)
                      }
        end

      @variables << {}
      @variables << {variable_name: "Non Public Editable Variables", pbo_assumption:"PBO Assumption", user_input: "", bold: [0,1,2]}
      @sensitivity.variables.where(public_editable: false).each do |v|
        @variables << {id: v.id,
                       variable_name:v.name,
                       B:v.machine_name,
                       pbo_assumption:v.pbo_assumption,
                       user_input:'',
                       variable_url: sensitivity_variable_path(@sensitivity, v)
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
