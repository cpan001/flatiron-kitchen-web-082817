class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true
  # validate :one_item_checked


  def ingredient_names=(array)
    new_ingredients = array.collect do |name|
      if name != "0"
        Ingredient.find_or_create_by(name: name)
      end
    end.compact
    # binding.pry
    self.ingredients = new_ingredients
  end

  def ingredient_names
    self.ingredients.collect {|ing| ing.name}
  end

  def one_item_checked
    ingredient_names.delete("0")
    if ingredient_names.empty?
      errors.add(:base, "At least one item needs to be checked")
    end
  end


end
