class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    authorize! :manage, :all
    @reports = Report.all
  end

  def show
  end

  # GET /reports/new
  def new
    @question = Question.find(params[:question_id])
    @report = Report.new(question: @question)
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to root_path, notice: 'Thank you for submitting a report!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    authorize! :manage, :all
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report template was successfully removed.' }
    end
  end

  private

  def render_authorization_error(_message)
    redirect_to root_url
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:question_id, :comment, :problem)
  end
end
