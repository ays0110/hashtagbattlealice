class BattlepointsController < ApplicationController
  before_action :set_battlepoint, only: [:show, :edit, :update, :destroy]

  # GET /battlepoints
  # GET /battlepoints.json
  def index
    @battlepoints = Battlepoint.all
  end

  # GET /battlepoints/1
  # GET /battlepoints/1.json
  def show
  end

  # GET /battlepoints/new
  def new
    @battlepoint = Battlepoint.new
  end

  # GET /battlepoints/1/edit
  def edit
  end

  # POST /battlepoints
  # POST /battlepoints.json
  def create
    @battlepoint = Battlepoint.new(battlepoint_params)

    respond_to do |format|
      if @battlepoint.save
        format.html { redirect_to @battlepoint, notice: 'Battlepoint was successfully created.' }
        format.json { render :show, status: :created, location: @battlepoint }
      else
        format.html { render :new }
        format.json { render json: @battlepoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battlepoints/1
  # PATCH/PUT /battlepoints/1.json
  def update
    respond_to do |format|
      if @battlepoint.update(battlepoint_params)
        format.html { redirect_to @battlepoint, notice: 'Battlepoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @battlepoint }
      else
        format.html { render :edit }
        format.json { render json: @battlepoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battlepoints/1
  # DELETE /battlepoints/1.json
  def destroy
    @battlepoint.destroy
    respond_to do |format|
      format.html { redirect_to battlepoints_url, notice: 'Battlepoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

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
