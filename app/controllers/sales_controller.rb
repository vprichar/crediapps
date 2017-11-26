class SalesController < ApplicationController
  #before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def clientsSearch
    @clubs = Client.where("(name||rfc) LIKE :q", :q => "%#{params[:name]}%") 
    render json: @clubs
  end
  
  def furnitureSearch
    @furnitures = Furniture.where("(name||description) LIKE :q", :q => "%#{params[:queri]}%") 
    render json: @furnitures
  end

  def add_item
    configuracion =Configuracion.last
    set_sale = Sale.find(params[:saleid])
    @furniture = Furniture.find(params[:id])
    item = @furniture
    existing_line__furniture = LineFurniture.where("furniture_id = ? AND sale_id = ?", item.id, set_sale.id).first 
    if  existing_line__furniture.blank?
      line_new = LineFurniture.new(:furniture_id=> item.id, :sale_id => set_sale.id, :quantity => 1)
      line_new.price = line_new.furniture.price * (1 + (configuracion.financing_rate * configuracion.Deadline) /100)
      line_new.save
      update_line_furniture_totals(line_new)
      update_sale(line_new)
      render json: line_new
    else
      existing_line__furniture.quantity += 1
      existing_line__furniture.save
      update_line_furniture_totals(existing_line__furniture)
      update_sale(existing_line__furniture)
      render json: existing_line__furniture
    end
  end

  def update_sale(lineFurniture)
    configuracion =Configuracion.last
    set_sale = Sale.find(lineFurniture.sale_id)
    hitch = 20
    set_sale.encganche = (hitch / 100.to_f) * lineFurniture.total_price
    set_sale.bonificacion = set_sale.encganche * ((configuracion.financing_rate * configuracion.Deadline ) /100)
    set_sale.toal=lineFurniture.total_price - set_sale.encganche - set_sale.bonificacion
    set_sale.save
  end


  def update_line_furniture_totals(line_item)
    configuracion =Configuracion.last
    line_item.total_price = line_item.price * line_item.quantity
    line_item.save
  end

  def getFurnitureSale
     sale = set_sale
     saleOb ={
       sale: sale,
       lineFurnitures: sale.lineFurnitures,
       furnitures: sale.furnitures
     }  
     render json:  saleOb
  end

  def setClient 
    set_sale
    client = Client.find(params[:clientId])
    set_sale.client = client
    set_sale.save
    render json:  set_sale.client
  end

  def getDeadlines
    months = [3,6,9,12]
    result = []
    configuracion =Configuracion.last
    set_sale
    counted = set_sale.toal.to_f / (1 + (configuracion.financing_rate * configuracion.Deadline) /100)
    #plazo = contado.to_f * (1 + (configuracion.financing_rate * 3) / 100) 
    months.each do |p|
      term = counted.to_f * (1 + (configuracion.financing_rate * p) / 100)
      payment = term / p.to_f
      spare = set_sale.toal.to_f - term
      result.push({numero:p, total:term, pago:payment, ahorra:spare })
    end
    render json: result
  end



  

  
  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.create
    @sale.save
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end



  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:payment_id, :toal, :encganche, :bonificacion, :status)
    end
end
