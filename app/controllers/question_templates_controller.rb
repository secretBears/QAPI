class QuestionTemplatesController < ApplicationController
  before_action :set_question_template, only: [:show, :edit, :update, :destroy]

                                  # GET /question_templates
  # GET /question_templates.json
  def index
    authorize! :manage, :all
    @question_templates = QuestionTemplate.all
  end

  # GET /question_templates/1
  # GET /question_templates/1.json
  def show
  end

  # GET /question_templates/new
  def new
    authorize! :manage, :all
    @question_template = QuestionTemplate.new
    @question_template.build_query
    @places = Place.all
  end

  # GET /question_templates/1/edit
  def edit
    authorize! :manage, :all
    @places = Place.all
  end

  # POST /question_templates
  # POST /question_templates.json
  def create
    authorize! :manage, :all
    @question_template = QuestionTemplate.new(question_template_params)

    respond_to do |format|
      if @question_template.save
        format.html do redirect_to question_template_path(@question_template),
                                   notice: 'Question template was successfully created.'
        end
        format.json { render action: 'show', status: :created, location: @question_template }
      else
        format.html { render action: 'new' }
        format.json { render json: @question_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_templates/1
  # PATCH/PUT /question_templates/1.json
  def update
    authorize! :manage, :all
    respond_to do |format|
      if @question_template.update(question_template_params)
        format.html do redirect_to question_template_path(@question_template),
                                   notice: 'Question template was successfully updated.'
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_templates/1
  # DELETE /question_templates/1.json
  def destroy
    authorize! :manage, :all
    @question_template.destroy
    respond_to do |format|
      format.html { redirect_to question_templates_url, notice: 'Question template was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def render_authorization_error(message)
    redirect_to root_url
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_question_template
      @question_template = QuestionTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_template_params
      params.require(:question_template).permit(:question, query_attributes: [:id, :query_hash, :answer_property,
                                                                              :location_property])
    end

    def render_json_error
      render "edit"
    end
end
