class BattlepointsController < ApplicationController
  before_action :set_battlepoint, only: [:show, :edit, :update, :destroy]

# NO API CALLS TO MODIFY BATTLEPOINTS

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battlepoint
      @battlepoint = Battlepoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battlepoint_params
      params.require(:battlepoint).permit(:battle_id, :hashtag, :count)
    end
end
