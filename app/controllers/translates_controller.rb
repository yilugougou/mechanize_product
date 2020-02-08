# -*- encoding : utf-8 -*-
class TranslatesController < ApplicationController
  before_action :set_translate, only: [:show, :edit, :update, :destroy]

  # GET /translates
  # GET /translates.json
  def index
    @translates = Translate.all
  end

  # GET /translates/1
  # GET /translates/1.json
  def show
  end

  # GET /translates/new
  def new
    @translate = Translate.new
  end

  # GET /translates/1/edit
  def edit
  end

  # POST /translates
  # POST /translates.json
  # POST /translations
  # POST /translations.json
  def create
    @translation = Translation.new(translation_params)

    require 'translation_tool'
    @result = ""
    query = translation_params[:input_text]
    begin
      if query.present?
        @result = TranslationTool.new.start(query)
      end
    rescue Exception => e
      Rails.logger.error e
      Rails.logger.error e.backtrace.join("\n")
    end


    respond_to do |format|
      format.html { render :edit }
    end
  end

  def get_translate
    require 'translation_tool'
    @results = TranslationTool.new.start_google(params[:q], params[:tl])
    render :index
  end

  # PATCH/PUT /translates/1
  # PATCH/PUT /translates/1.json
  def update
    respond_to do |format|
      if @translate.update(translate_params)
        format.html { redirect_to @translate, notice: 'Translate was successfully updated.' }
        format.json { render :show, status: :ok, location: @translate }
      else
        format.html { render :edit }
        format.json { render json: @translate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /translates/1
  # DELETE /translates/1.json
  def destroy
    @translate.destroy
    respond_to do |format|
      format.html { redirect_to translates_url, notice: 'Translate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_translate
      @translate = Translate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def translate_params
      params.require(:translate).permit(:q, :text, :tl)
    end
end
