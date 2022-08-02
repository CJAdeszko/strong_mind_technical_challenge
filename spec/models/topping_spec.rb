require 'rails_helper'

RSpec.describe Topping, type: :model do
  it 'should have a name attribute' do
    topping = Topping.create!(name: 'Pepperoni')

    expect(topping.name).to eq('Pepperoni')
  end
end
