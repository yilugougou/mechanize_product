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
    url = "https://detail.1688.com/offer/36054648174.html?spm=a2615.7691456.0.0.d3059e2TmvMaz"
    @response = HTTParty.get(url)
    # binding.pry

    # url = "https://login.taobao.com/member/login.jhtml?style=b2b&css_style=b2b&from=b2b&newMini2=true&full_redirect=true&redirect_url=https%3A%2F%2Flogin.1688.com%2Fmember%2Fjump.htm%3Ftarget%3Dhttps%253A%252F%252Flogin.1688.com%252Fmember%252FmarketSigninJump.htm%253FDone%253Dhttp%25253A%25252F%25252Fdetail.1688.com%25252Foffer%25252F36054648174.html%25253Fspm%25253Da2615.7691456.0.0.d3059e2TmvMaz&reg=http%3A%2F%2Fmember.1688.com%2Fmember%2Fjoin%2Fenterprise_join.htm%3Flead%3Dhttp%253A%252F%252Fdetail.1688.com%252Foffer%252F36054648174.html%253Fspm%253Da2615.7691456.0.0.d3059e2TmvMaz%26leadUrl%3Dhttp%253A%252F%252Fdetail.1688.com%252Foffer%252F36054648174.html%253Fspm%253Da2615.7691456.0.0.d3059e2TmvMaz%26tracelog%3Dnotracelog_s_reg"
    require 'mechanize'
    Mechanize.start do |agent|
      agent.get(url) do |page|
        binding.pry
        @title = page.search('#mod-detail-title .d-title').text.strip
        @product_color = []
        page.search('.obj-leading .obj-content li').each do |color|
          @product_color.push(color.text.strip)
        end
        @size_infos = []
        page.search('.obj-sku .obj-content .table-sku tr').each do |size_info|
          @size_infos.push({
            name: size_info.search('.name').text.strip,
            price: size_info.search('.price').text.strip,
            count: size_info.search('.count').text.strip
          })
        end
        @product_info = ""
        page.search('#mod-detail-attributes .obj-content tr').each do |info_tr|
          info_tr.search('td').each_with_index do |td, index|
            if td.text.strip.present?
              if index%2 == 0
                @product_info += "#{td.text.strip}："
              else
                @product_info += "#{td.text.strip}   "
              end
            end
          end
        end
      end
    end
    render json: { title: @title, product_color: @product_color, size_infos: @size_infos, product_info: @product_info }
    #@response = HTTParty.get(detailUrl)
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
