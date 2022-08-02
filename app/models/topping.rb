class Topping < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :pizza_toppings, dependent: :destroy
  has_many :pizzas, through: :pizza_toppings

  def initialize(params={})
    super
  end
end
