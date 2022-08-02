require 'rails_helper'

RSpec.describe Pizza, type: :model do
  it 'should have a name attribute' do
    topping = Topping.create!(name: 'Pepperoni')
    pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

    expect(pizza.name).to eq('Pepperoni pizza')
  end
end
