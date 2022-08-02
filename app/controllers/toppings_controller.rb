class ToppingsController < ApplicationController
  def index
    @toppings = Topping.all
  end

  def show
    @topping = Topping.find(params[:id])
  end

  def new
    @topping = Topping.new
  end

  def create
    @topping = Topping.new(topping_params)

    if @topping.save
      redirect_to @topping
    else
      flash.now[:error] = "#{@topping.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def edit
    @topping = Topping.find(params[:id])
  end

  def update
    @topping = Topping.find(params[:id])

    if @topping.update(topping_params)
      flash[:success] = "#{@topping.name} topping successfully updated."
      redirect_to @topping
    else
      flash.now[:error] = "#{@topping.errors.full_messages.join(', ')}"
      render :edit
    end
  end

  def destroy
    @topping = Topping.find(params[:id])

    if @topping.destroy
      redirect_to toppings_path
    else
      flash.now[:error] = "There was a problem deleting the #{@topping.name} record"
      render @topping
    end
  end

  private

  def topping_params
    params.require(:topping).permit(:name)
  end
end
