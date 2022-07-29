# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /jobs or /jobs.json
  def index
    @jobs = if current_user.has_role? :employer
              current_user.jobs.page(params[:page])
            else
              Job.page(params[:page])
            end
  end

  # GET /jobs/1 or /jobs/1.json
  def show; end

  # GET /jobs/new
  def new; end

  # GET /jobs/1/edit
  def edit; end

  # POST /jobs or /jobs.json
  def create
    @job = current_user.jobs.build(job_params)
    respond_to do |format|
      if @job.save
        format.html { redirect_to job_url(@job), notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_url(@job), notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.delete

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:id, :job_title, :salary, :experience, :skillset, :description)
  end
end
