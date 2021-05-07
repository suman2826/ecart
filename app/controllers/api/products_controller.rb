module Api
  class ProductsController < ApplicationController
    skip_before_action :authenticate!, except: [:show]
    before_action :fetch_category
    
    def index
      product_name = params[:name]
      if product_name.blank?
        products = @category.products.paginate(page: params[:page],per_page: 4)
      else
        product_name.insert(0,'%')
        product_name << '%'
        products = Product.where("name like ?",product_name).paginate(page: params[:page],per_page: 4)
        if products.blank?
          products = @category.products.paginate(page: params[:page],per_page: 4)
        end
      end
      binding.pry
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
