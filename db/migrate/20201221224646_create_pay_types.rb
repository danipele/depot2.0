class CreatePayTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :pay_types do |t|
      t.string :name
    end
  end
end
