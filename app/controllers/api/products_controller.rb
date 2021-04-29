module Api
  class ProductsController < ApplicationController
    skip_before_action :authenticate!
    before_action :fetch_category
    
    def index
      products = @category.products
      render json: products
    end

    def show
      product = @category.products
                  .where(id: params[:id]).first

      data = product.attributes.symbolize_keys
      data.delete(:category_id)
      data.merge!(category: {
                    id: @category.id,
                    name: @category.description
                  })
      
      render json: data and return
    end

    private

    
    def fetch_category
      @category = Category.find params[:category_id]
    end
  end
end
