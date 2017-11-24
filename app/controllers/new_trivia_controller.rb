require 'net/http'

class NewTriviaController < ApplicationController
  before_action :set_new_trivium, only: [:show, :edit, :update, :destroy]

  # GET /new_trivia
  # GET /new_trivia.json
  def index
    @new_trivia = NewTrivium.all
  end

  # GET /new_trivia/1
  # GET /new_trivia/1.json
  def show
  end

  # GET /new_trivia/new
  def new
    @new_trivium = NewTrivium.new
  end

  # GET /new_trivia/1/edit
  def edit
  end

  # POST /new_trivia
  # POST /new_trivia.json
  def create
    @new_trivium = NewTrivium.new(new_trivium_params)
    http = Net::HTTP.new('localhost', '5000')

    request = Net::HTTP::Post.new('/openie', {'Content-Type' => 'application/json'})
    request.body = new_trivium_params.to_json

    response = http.request(request)
    @response = JSON.parse(response.body)

    http2 = Net::HTTP.new('huwalaumba.mooo.com', '5000')
    request2 = Net::HTTP::Post.new('/article', {'Content-Type' => 'application/json'})
    request2.body = new_trivium_params.to_json
    response2 = http2.request(request2)
    @response2 = JSON.parse(response2.body)

    render :index
  end

  # PATCH/PUT /new_trivia/1
  # PATCH/PUT /new_trivia/1.json
  def update
    respond_to do |format|
      if @new_trivium.update(new_trivium_params)
        format.html { redirect_to @new_trivium, notice: 'New trivium was successfully updated.' }
        format.json { render :show, status: :ok, location: @new_trivium }
      else
        format.html { render :edit }
        format.json { render json: @new_trivium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /new_trivia/1
  # DELETE /new_trivia/1.json
  def destroy
    @new_trivium.destroy
    respond_to do |format|
      format.html { redirect_to new_trivia_url, notice: 'New trivium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_trivium
      @new_trivium = NewTrivium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_trivium_params
      params.require(:new_trivium).permit(:content, :title)
    end
end
