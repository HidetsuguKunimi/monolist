class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      response = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
    
    @amazon_items=response.items
    
    end
  end

  def show

    @want=Ownership.where(item_id: params[:id] , type: 'Want').pluck(:user_id)
    @want_users=User.where(id: @want)

    @have=Ownership.where(item_id: params[:id] , type: 'Have').pluck(:user_id)
    @have_users=User.where(id: @have)

  end

  private
  
  def set_item
    @item = Item.find(params[:id])
  end
end

