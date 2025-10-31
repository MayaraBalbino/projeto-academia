class PlanosController < ActionController::API
  before_action :set_plano, only: [:show, :update, :destroy]

  # GET /planos
  def index
    @planos = Plano.all
    render json: @planos
  end

  # GET /planos:id
  def show
    render json: @plano
  end

  # POST /planos
  def create
    @plano = Plano.new(plano_params)
    if @plano.save
      render json: @plano, status: :created
    else
      render json: @plano.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planos/:id
  def update
    if @plano.update(plano_params)
      render json: @plano
    else
      render json: @plano.errors, status: :unprocessable_entity
    end
  end 

  # DELETE /planos/:id
  def destroy
    @plano.destroy
    head :no_content
  end

  private

  def set_plano
    @plano = Plano.find(params[:id])
  end

  def plano_params
    params.require(:plano).permit(:nome_plano, :descricao, :valor_mensal, :duracao_meses)
  end

end