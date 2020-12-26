class Product < ApplicationRecord
  validates :title, :description, :image_url, :locale, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :locale, length: { is: 2 }

  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_line_items_empty

  private

  def ensure_line_items_empty
    return if line_items.empty?

    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
