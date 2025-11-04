class PagamentosController < ActionController::API
  before_action :set_pagamento, only: [:show, :update, :destroy]

  # GET /pagamentos
  def index
    @pagamentos = Pagamento.all
    render json: @pagamentos
  end

  # GET /pagamentos/:id
  def show
    render json: @pagamento
  end

  # POST /pagamentos
  def create
    @pagamento = Pagamento.new(pagamento_params)
    if @pagamento.save
      render json: @pagamento, status: :created
    else
      render json: { errors: @pagamento.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pagamentos/:id
  def update
    if @pagamento.update(pagamento_params)
      render json: @pagamento
    else
      render json: @pagamento.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pagamentos/:id
  def destroy
    @pagamento.destroy
    head :no_content
  end

  private

  def set_pagamento
    @pagamento = Pagamento.find(params[:id])
  end

  def pagamento_params
    params.require(:pagamento).permit(
      :aluno_id,
      :plano_id,
      :data_pagamento,
      :data_vencimento,
      :valor,
      :forma_pagamento,
      :referente_a,
      :status)
  end


end