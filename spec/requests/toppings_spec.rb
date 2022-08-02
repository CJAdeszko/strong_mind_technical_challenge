require 'rails_helper'

RSpec.describe "Toppings", type: :request do
  describe "toppings index" do
    it 'retrieves a list of all toppings' do
      topping = Topping.create!(name: 'Pepperoni')

      get toppings_path

      expect(response).to be_successful
      expect(response.body).to include(topping.name)
    end

    it 'renders the index template' do
      get toppings_path

      expect(response).to render_template('index')
    end
  end

  describe 'toppings#create' do
    it 'renders the new template' do
      get new_topping_path

      expect(response).to render_template('new')
    end

    it 'increases the number of toppings by 1' do
      topping = Topping.create!(name: 'Pepperoni')

      expect(Topping.count).to eq(1)
    end

    it 'redirects to the show view' do
      post toppings_path, params: { topping: { name: 'Pepperoni' } }

      expect(response).to redirect_to(assigns(:topping))
      follow_redirect!
      expect(response).to render_template(:show)
    end
  end

  describe 'toppings#update' do
    it 'renders the edit template' do
      topping = Topping.create!(name: 'Pepperoni')

      get edit_topping_path(topping)

      expect(response).to render_template('edit')
    end

    it 'allows name changes' do
      topping = Topping.create!(name: 'Pepperoni')

      put topping_path(topping), params: { topping: { name: 'Spicy pepperoni' } }

      expect(topping.name).to eq('Spicy pepperoni')
      expect(response.status).to eq(302)
      expect(response).to redirect_to(assigns(:topping))
    end
  end
end
