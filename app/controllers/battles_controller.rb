class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show]  

  # GET /battles
  # GET /battles.json
  def index
    @battles = current_user.battles
  end

  # GET /battles/1
  # GET /battles/1.json
  def show
      @battle = Battle.find(params[:id])
      
      #display counts
      @hash1count = @battle.battlepoints.where(:hashtag=>1).last.tweetcount
      @hash2count = @battle.battlepoints.where(:hashtag=>2).last.tweetcount
      
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles
  # POST /battles.json
  def create
    @battle = Battle.new(battle_params)
    
    #Cleanup hashtags
    @battle.hashtag1 = battle.hashtag1.gsub('#', '')
    @battle.hashtag2 = battle.hashtag2.gsub('#', '')
    @battle.user_id = current_user.id
    @battle.status = 1
    
    #Pull in the ID of the newest tweet since creation
    @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "9v4sR5JGNX8ellOM1HvDpYsi9"
        config.consumer_secret     = "TNLyRCW94YmQzD6Oeqsi7SdqhSKnMJt4Ze6lndMf0L2AwnlF1B"
        config.access_token        = "1142957198-gsXD8S1KDWCFgOOEKVsblPIqj9nTwF841LMQsVo"
        config.access_token_secret = "qnV52jqXWG0PVN88Nypof0rIhWyEuVBjfoZIzFhXsrj6C"
    end
    
    @tweets =  @client.search("a", :result_type => "recent").take(1)
    @battle.since_number= @tweets.first.id

    respond_to do |format|
      if @battle.save
          #Create starting point of 0 for each tag
          @battlepoint1 = Battlepoint.new(:battle=>@battle, :hashtag=>1, :tweetcount=>0)
          @battlepoint2 = Battlepoint.new(:battle=>@battle, :hashtag=>2, :tweetcount=>0)
          @battlepoint1.save
          @battlepoint2.save

        format.html { redirect_to @battle, notice: 'Battle was successfully created.' }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end


  def endbattle
      
      #Only the creator can end the battle
      @battle = Battle.find(params[:id])
      if current_user.id == @battle.user_id
          @battle.status = 0
          @battle.save
      end
      
      respond_to do |format|
          format.html { redirect_to battle_path }
      end
  
  end

  # PATCH/PUT /battles/1
  # PATCH/PUT /battles/1.json

  def update
    respond_to do |format|
        
        #Only the creator can update the battle
      if @battle.update(battle_params) && current_user.id == @battle.user_id
        format.html { redirect_to @battle, notice: 'Battle was successfully updated.' }
        format.json { render :show, status: :ok, location: @battle }
      else
        format.html { render :edit }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1
  # DELETE /battles/1.json
  def destroy
      
      #Only the creator can destroy the battle
    if current_user.id == @battle.user_id
        @battle.destroy
    end
    respond_to do |format|
      format.html { redirect_to battles_url, notice: 'Battle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def battle_params
        params.require(:battle).permit(:hashtag1, :hashtag2, :user_id, :since_number, :status, :ends_at, :hash1color, :hash2color)
    end
end
