module CitizenBudgetModel
  class Question < ActiveRecord::Base
    acts_as_list scope: :section_id, top_of_list: 0
    translates :name, :title, :description, :modal, :popover, :labels, :unit_name, :placeholder, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :section

    validates_presence_of :section_id
    validates_uniqueness_of :machine_name, scope: :section_id, allow_blank: true
    validates_format_of :machine_name, with: /\A[a-z_][a-z_0-9]*\z/, allow_blank: true
    validates_numericality_of :default_value, :unit_value, :minimum, :maximum, allow_blank: true
    validates_numericality_of :maxlength, :rows, :cols, :size, allow_blank: true, greater_than: 0, only_integer: true
    validates_inclusion_of :widget, in: %w(slider), allow_blank: true
    validates_numericality_of :step, allow_blank: true, greater_than: 0

    # @see http://www.postgresql.org/docs/9.3/static/sql-keywords-appendix.html
    # Nokogiri::HTML(open(url).read).xpath('//table/tbody/tr[td[2][text()="reserved"]]/td[1]//text()').map{|s| s.to_s.downcase}
    validates_exclusion_of :machine_name, in: %w(all analyse analyze and any
      array as asc asymmetric both case cast check collate column constraint
      create current_catalog current_date current_role current_time
      current_timestamp current_user default deferrable desc distinct do else
      end except false fetch for foreign from grant group having in initially
      intersect into lateral leading limit localtime localtimestamp not null
      offset on only or order placing primary references returning select
      session_user some symmetric table then to trailing true union unique user
      using variadic when where window with), allow_blank: true

    validate :all_or_none_of_minimum_and_maximum_and_step_should_be_present
    validate :minimum_must_be_less_than_maximum
    validate :default_value_must_be_an_option
    validate :labels_must_agree_with_options

    after_initialize :get_options, :get_labels
    before_validation :set_options, :set_labels

    attr_accessor :minimum, :maximum, :step, :labels_as_list, :options_as_list

    # Returns a question's name, title or "Untitled".
    #
    # @return [String] a question's name, title or "Untitled"
    def display_name
      name.present? && name || title.present? && title || _('Untitled')
    end

    # Returns the equation or a default equation if not set.
    #
    # @return [String] an equation
    def working_equation
      # @note This method is stubbed.
      default_equation
    end

    # Returns a default equation, where the difference between the chosen value
    # and the default value is multiplied by the unit value.
    #
    # @return [String] a default equation
    def default_equation
      if machine_name? && default_value? && unit_value?
        "(#{machine_name} - #{default_value}) * #{unit_value}"
      end
    end

    # Solves the equation with the variable's given value.
    #
    # @param [Float,String] value value
    # @return [Float] a solution
    def solve(value)
      eval(working_equation, Struct.new(machine_name.to_sym).new(Float(value)).instance_eval{binding})
    end

  private

    # Sets the `minimum`, `maximum` and `step` virtual attributes.
    def get_options
      if options.present?
        @minimum = options.first.to_f
        @maximum = options.last.to_f
        @step = (options[1] - options[0]).round(3)
      end
    end

    # Sets the `labels_as_list` virtual attribute.
    def get_labels
      if labels.present?
        @labels_as_list = labels.join("\n")
      end
    end

    # Sets the `options` attribute based on `minimum`, `maximum` and `step`.
    def set_options
      if minimum.present? && maximum.present? && step.present?
        self.options = (BigDecimal(minimum.to_s)..BigDecimal(maximum.to_s)).step(BigDecimal(step.to_s)).map(&:to_f)
        unless options.last == maximum.to_f
          self.options << maximum.to_f
        end
      else
        self.options = []
      end
    end

    # Sets the `labels` attribute based on `labels_as_list`.
    def set_labels
      if labels_as_list.present?
        self.labels = labels_as_list.split("\n").map(&:strip).reject(&:empty?)
      end
    end

    def all_or_none_of_minimum_and_maximum_and_step_should_be_present
      unless minimum.present? && maximum.present? && step.present? || minimum.blank? && maximum.blank? && step.blank?
        [:minimum, :maximum, :step].each do |attribute|
          if send(attribute).blank?
            errors.add(attribute, :blank)
          end
        end
      end
    end

    def minimum_must_be_less_than_maximum
      if minimum.present? && maximum.present? && minimum.to_f >= maximum.to_f
        errors.add(:minimum, _('must be less than maximum'))
      end
    end

    def default_value_must_be_an_option
      if options.present? && default_value.present?
        unless options.include?(default_value) || options.include?(default_value.to_f)
          errors.add(:default_value, _('must be a valid option'))
        end
      end
    end

    def labels_must_agree_with_options
      if labels.present? && options.present?
        unless labels.size == options.size
          errors.add(:labels, _('must agree with options'))
        end
      end
    end
  end
end
