class Order < ApplicationRecord
  validates :name, :address, :email, presence: true
  validate :check_valid_pay_type

  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      line_items << line_item
    end
  end

  def check_valid_pay_type
    PayTypes.all_pay_types_names.to_a.include?(pay_type)
  end
end
