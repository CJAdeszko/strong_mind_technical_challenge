require 'rails_helper'

RSpec.describe "Pizzas", type: :request do
  describe "pizzas index" do
    it 'retrieves a list of all pizzas' do
      topping = Topping.create!(name: 'Pepperoni')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

      get pizzas_path

      expect(response).to be_successful
      expect(response.body).to include(pizza.name)
    end

    it 'renders the index template' do
      get pizzas_path

      expect(response).to render_template('index')
    end
  end

  describe 'pizzas#create' do
    it 'renders the new template' do
      get new_pizza_path

      expect(response).to render_template('new')
    end

    it 'increases the number of pizzas by 1' do
      topping = Topping.create!(name: 'Pepperoni')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

      expect(Pizza.count).to eq(1)
    end

    #not sure this test belongs here, but not 100% certain where to test
    #creation of instance of join model
    it 'creates associated pizza_toppings records' do
      topping = Topping.create!(name: 'Pepperoni')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

      expect(pizza.toppings).to include(topping)
      expect(PizzaTopping.count).to eq(1)
    end

    #I'm not sure why this test is failing...
    #It shows response.status 200 instead of 302 despite redirecting succesfully
    #Rails server confirms response is 302
    it 'redirects to the show view' do
      topping = Topping.create!(name: 'Pepperoni')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

      post pizzas_path, params: { pizza: { name: 'Pepperoni pizza', topping_ids: [topping.id] } }
      expect(response).to redirect_to(assigns(:pizza))
    end
  end

  describe 'pizzas#update' do
    it 'renders the edit template' do
      topping = Topping.create!(name: 'Pepperoni')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

      get edit_pizza_path(pizza)

      expect(response).to render_template('edit')
    end

    it 'allows name changes' do
      topping = Topping.create!(name: 'Pepperoni')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping.id])

      put pizza_path(pizza), params: { pizza: { name: 'Double pepperoni pizza' } }
      
      expect(pizza.name).to eq('Double pepperoni pizza')
      expect(response.status).to eq(302)
      expect(response).to redirect_to(assigns(:pizza))
    end

    it 'allows toppings to change' do
      topping_one = Topping.create!(name: 'Pepperoni')
      topping_two = Topping.create!(name: 'Sausage')
      pizza = Pizza.create!(name: 'Pepperoni pizza', topping_ids: [topping_one.id])

      put pizza_path(pizza), params: { pizza: { name: 'Sausage and pepperoni pizza', topping_ids: [topping_one.id, topping_two.id] } }

      expect(pizza.name).to eq('Sausage and pepperoni pizza')
      expect(pizza.toppings).to include(topping_one)
      expect(pizza.toppings).to include(topping_two)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(assigns(:pizza))
    end
  end
end
