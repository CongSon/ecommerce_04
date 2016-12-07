class Promotion < ApplicationRecord
  belongs_to :product

  scope :is_sale_of, -> (id, date) do where("product_id =?", id)
    .where("start_date < '#{date}' AND end_date > '#{date}'")
  end
end
