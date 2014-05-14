class Admin::QuestionTemplatesController < Admin::AdminController
  before_action :set_question_template, only: [:show, :edit, :update, :destroy]

  # GET /question_templates
  # GET /question_templates.json
  def index
    @question_templates = QuestionTemplate.all
  end

  # GET /question_templates/1
  # GET /question_templates/1.json
  def show
  end

  # GET /question_templates/new
  def new
    @question_template = QuestionTemplate.new
  end

  # GET /question_templates/1/edit
  def edit
  end

  # POST /question_templates
  # POST /question_templates.json
  def create
    @question_template = QuestionTemplate.new(question_template_params)

    respond_to do |format|
      if @question_template.save
        format.html do redirect_to admin_question_template_path(@question_template),
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
    respond_to do |format|
      if @question_template.update(question_template_params)
        format.html do redirect_to admin_question_template_path(@question_template),
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
    @question_template.destroy
    respond_to do |format|
      format.html { redirect_to admin_question_templates_url, notice: 'Question template was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_template
      @question_template = QuestionTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_template_params
      params[:question_template].permit(:question, :query_id)
    end
end
