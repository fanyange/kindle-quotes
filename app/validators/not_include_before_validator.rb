class NotIncludeBeforeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if Quote.where("instr(?, #{attribute}) > 0", value).any?
      record.errors.add attribute, "includes before"
    end
  end
end
