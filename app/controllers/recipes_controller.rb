class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
        recipes = Recipe.all
        render json: recipes, status: :ok 
    end

    def create
          user = User.find(session[:user_id])
          recipe = user.recipes.create!(recipe_params)
          render json: recipe, status: :created
        
    end     
    
    private

    def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
    end

      def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end

end
