module Api
  class CategoriesController < ApplicationController
    skip_before_action :authenticate!, only: [:index]
    
    def index
      records = Category.all
      render json: records
    end
    
  end
end
