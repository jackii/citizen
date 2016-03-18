module CitizenBudgetModel
  class Variable < ActiveRecord::Base
    acts_as_list scope: :sensitivity_id, top_of_list: 0
    translates :name, :unit_name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :sensitivity

    validates_presence_of :sensitivity_id
    validates_uniqueness_of :machine_name, scope: :section_id, allow_blank: true
    validates_format_of :machine_name, with: /\A[a-z_][a-z_0-9]*\z/, allow_blank: true
    validates_numericality_of :default_value, :pbo_assumption, :minimum, :maximum, allow_blank: true
    validates_numericality_of :step, greater_than: 0, allow_blank: true

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


  end
end
