class FavoritesController < ApplicationController
  def index
    @favorities = Favorite.where(user_id: current_user.id)
  end

  def add_favorite_list
    @favorite = Favorite.where(list_id: params[:list_id], user_id: current_user.id)
    
    if @favorite.present?
      respond_to do |format|
        format.js { flash[:notice] = 'List has already been favorited.' }
      end
    else
      @favorite = Favorite.new(list_id: params[:list_id], user_id: current_user.id)

      respond_to do |format|
        if @favorite.save
          format.js { flash[:notice] = 'List was successfully favorited.' }
        end
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:favorite).permit(:list_id)
    end
end
