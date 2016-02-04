module CitizenBudgetModel
  class Impact < ActiveRecord::Base
    acts_as_list scope: :sensitivity_section_id, top_of_list: 0
    translates :name, fallbacks_for_empty_translations: true
    globalize_accessors

    belongs_to :sensitivity_section
    has_many :impact_variables, -> { order(:year) }, dependent: :destroy
    accepts_nested_attributes_for :impact_variables

    validates_presence_of :sensitivity_section_id
    validates_format_of :machine_name, with: /\A[a-z_][a-z_0-9]*\z/, allow_blank: true
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

    def year_1
      impact_variables.where(:year => 'Year 1')
    end

    def year_2
      impact_variables.where(:year => 'Year 2')
    end

    def year_5
      impact_variables.where(:year => 'Year 5')
    end
  end
end
