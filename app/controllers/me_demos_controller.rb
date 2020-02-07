# -*- encoding : utf-8 -*-
class MeDemosController < ApplicationController
  before_action :set_me_demo, only: [:show, :edit, :update, :destroy]

  # GET /me_demos
  # GET /me_demos.json
  def index
    @me_demos = MeDemo.all
  end

  # GET /me_demos/1
  # GET /me_demos/1.json
  def show
  end

  # GET /me_demos/new
  def new
    @me_demo = MeDemo.new
  end

  def grab
    require 'product'
    products = Product.new.fetch_start()

    render json: { title: products[:title], product_color: products[:pcolor], size_infos: products[:psizes], product_info: products[:pinfos] }
  end

  # GET /me_demos/1/edit
  def edit
  end

  # POST /me_demos
  # POST /me_demos.json
  def create
    @me_demo = MeDemo.new(me_demo_params)

    respond_to do |format|
      if @me_demo.save
        format.html { redirect_to @me_demo, notice: 'Me demo was successfully created.' }
        format.json { render :show, status: :created, location: @me_demo }
      else
        format.html { render :new }
        format.json { render json: @me_demo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /me_demos/1
  # PATCH/PUT /me_demos/1.json
  def update
    respond_to do |format|
      if @me_demo.update(me_demo_params)
        format.html { redirect_to @me_demo, notice: 'Me demo was successfully updated.' }
        format.json { render :show, status: :ok, location: @me_demo }
      else
        format.html { render :edit }
        format.json { render json: @me_demo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /me_demos/1
  # DELETE /me_demos/1.json
  def destroy
    @me_demo.destroy
    respond_to do |format|
      format.html { redirect_to me_demos_url, notice: 'Me demo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_me_demo
      @me_demo = MeDemo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def me_demo_params
      params.require(:me_demo).permit(:me_text)
    end
end
