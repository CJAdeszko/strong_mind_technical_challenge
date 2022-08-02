class PizzasController < ApplicationController
  def index
    @pizzas = Pizza.all
  end

  def show
    @pizza = Pizza.find(params[:id])
  end

  def new
    @pizza = Pizza.new
  end

  def create
    @pizza = Pizza.new(pizza_params)

    if @pizza.save
      redirect_to @pizza
    else
      flash.now[:error] = "#{@pizza.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
    @pizza = Pizza.find(params[:id])
  end

  def update
    @pizza = Pizza.find(params[:id])
    params[:pizza][:topping_ids] = [] unless params[:pizza][:topping_ids].present?

    if @pizza.update(pizza_params)
      flash[:success] = "#{@pizza.name} pizza successfully updated."
      redirect_to @pizza
    else
      flash.now[:error] = "#{@pizza.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    @pizza = Pizza.find(params[:id])

    if @pizza.destroy
      redirect_to pizzas_path
    else
      flash.now[:error] = "There was a problem deleting the #{@pizza.name} record"
      render @pizza
    end
  end

  private

  def pizza_params
    params.require(:pizza).permit(:name, topping_ids: [])
  end
end
