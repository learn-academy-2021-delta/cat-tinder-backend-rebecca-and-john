class CatsController < ApplicationController

  def index
    cats = Cat.all 
    render json: cats
  end

  def create
  end

  def update
  end

  def destroy
  end
    
end
