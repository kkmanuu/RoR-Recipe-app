class RecipeFoodsController < ApplicationController
  def index; end

  def new
    @user = current_user
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = @user.foods
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = RecipeFood.new(recipe_foods_params)
    @recipe_foods.recipe = @recipe
    if @recipe_foods.save
      flash[:notice] = 'Recipe item was created successfully'
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def destroy
    @recipe_foods = RecipeFood.find(params[:id])
    @recipe_foods.destroy
    flash[:notice] = 'Recipe Item was successfully deleted.'
    redirect_to recipe_path(@recipe_foods.recipe)
  end

  def recipe_foods_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
