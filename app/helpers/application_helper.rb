module ApplicationHelper
  def persistence(records)
    records.reject { |record| record.new_record? }
  end
end
