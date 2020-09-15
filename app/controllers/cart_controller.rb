class CartController < ApplicationController
  before_action :admin_restriction

  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def add
    item = Item.find(params[:item_id])
    if item.inventory >= cart.items[item]
      cart.add_item(item.id.to_s)
      flash[:success] = "#{item.name} was successfully added to your cart"
    else
      flash[:notice] = "Inventory limit reached for #{item.name}"
    end
    redirect_to '/cart'
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  private

  def admin_restriction
    render file: '/public/404' if current_admin?
  end
end
