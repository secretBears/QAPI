class QuestionPlaceholdersController < ApplicationController
  before_action :set_question_placeholder, only: [:show, :edit, :update, :destroy]

  # GET /question_placeholders
  # GET /question_placeholders.json
  def index
    @question_placeholders = QuestionPlaceholder.all
  end

  # GET /question_placeholders/1
  # GET /question_placeholders/1.json
  def show
  end

  # GET /question_placeholders/new
  def new
    @question_placeholder = QuestionPlaceholder.new
  end

  # GET /question_placeholders/1/edit
  def edit
  end

  # POST /question_placeholders
  # POST /question_placeholders.json
  def create
    @question_placeholder = QuestionPlaceholder.new(question_placeholder_params)

    respond_to do |format|
      if @question_placeholder.save
        format.html { redirect_to @question_placeholder, notice: 'Question placeholder was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question_placeholder }
      else
        format.html { render action: 'new' }
        format.json { render json: @question_placeholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_placeholders/1
  # PATCH/PUT /question_placeholders/1.json
  def update
    respond_to do |format|
      if @question_placeholder.update(question_placeholder_params)
        format.html { redirect_to @question_placeholder, notice: 'Question placeholder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question_placeholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_placeholders/1
  # DELETE /question_placeholders/1.json
  def destroy
    @question_placeholder.destroy
    respond_to do |format|
      format.html { redirect_to question_placeholders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_placeholder
      @question_placeholder = QuestionPlaceholder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_placeholder_params
      params.require(:question_placeholder).permit(:key, :value, :question_id)
    end
end
