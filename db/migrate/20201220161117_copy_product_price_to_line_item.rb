class CopyProductPriceToLineItem < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :price, :decimal
  end

  def up
    LineItem.all.each do |line_item|
      line_item.price = line_item.product.price
      line_item.save!
    end
  end
end
