class PayTypes < ApplicationRecord
  def self.all_pay_types_names
    PayTypes.all.collect { |pay_type| [pay_type.name] }
  end
end
