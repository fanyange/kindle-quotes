class NotIncludedBeforeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Quote.where("#{attribute} like ?", "#{value}%").any?
      record.errors.add attribute, "was included before"
    end
  end
end
