class Category < ApplicationRecord
  has_many :suggested_products
  has_many :products
  validates :name, presence: true, uniqueness: true, allow_blank: false

  def update_category id
    last_right = get_last_right
    if id.empty?
      last_right.nil? ? self.update(lft: 1, rgt: 2, depth: 0)
        : self.update(lft: last_right + 1, rgt: last_right + 2, depth: 0)
    else
      parent_category = Category.find_by id: id
      Category.where("rgt >= ?", parent_category.rgt)
        .update_all("rgt = rgt + 2")
      Category.where("lft >= ?", parent_category.rgt)
        .update_all("lft = lft + 2")
      self.update(lft: parent_category.rgt, rgt: parent_category.rgt + 1,
        depth: parent_category.depth + 1)
    end
  end

  def delete_category
    Category.where("rgt >= ?", self.rgt)
      .update_all("rgt = rgt - 2")
    Category.where("lft >= ?", self.rgt)
      .update_all("lft = lft - 2")
  end

  def is_leaf?
    self.rgt == self.lft + 1
  end

  private
  def get_last_right
    Category.maximum(:rgt)
  end
end
