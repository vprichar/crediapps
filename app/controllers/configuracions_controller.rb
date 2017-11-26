class ConfiguracionsController < ApplicationController
  before_action :set_configuracion, only: [:show, :edit, :update, :destroy]

  # GET /configuracions
  # GET /configuracions.json
  def index
    @configuracions = Configuracion.all
  end

  # GET /configuracions/1
  # GET /configuracions/1.json
  def show
  end

  # GET /configuracions/new
  def new
    @configuracion = Configuracion.new
  end

  # GET /configuracions/1/edit
  def edit
  end

  # POST /configuracions
  # POST /configuracions.json
  def create
    @configuracion = Configuracion.new(configuracion_params)

    respond_to do |format|
      if @configuracion.save
        format.html { redirect_to @configuracion, notice: 'Configuracion was successfully created.' }
        format.json { render :show, status: :created, location: @configuracion }
      else
        format.html { render :new }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /configuracions/1
  # PATCH/PUT /configuracions/1.json
  def update
    respond_to do |format|
      if @configuracion.update(configuracion_params)
        format.html { redirect_to @configuracion, notice: 'Configuracion was successfully updated.' }
        format.json { render :show, status: :ok, location: @configuracion }
      else
        format.html { render :edit }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /configuracions/1
  # DELETE /configuracions/1.json
  def destroy
    @configuracion.destroy
    respond_to do |format|
      format.html { redirect_to configuracions_url, notice: 'Configuracion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_configuracion
      @configuracion = Configuracion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def configuracion_params
      params.require(:configuracion).permit(:financing_rate, :Deadline)
    end
end
