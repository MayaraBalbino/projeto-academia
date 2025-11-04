class TreinosController < ActionController::API
  before_action :set_treino, only: [:show, :update, :destroy]

  # GET /treinos
  def index
    @treinos = Treino.all
    render json: @treinos
  end

  # GET /treinos/:id
  def show
    render json: @treino
  end

  # POST /treinos
  def create
    @treino = Treino.new(treino_params)
    if @treino.save
      render json: @treino, status: :created
    else
      render json: { errors: @treino.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treinos/:id
  def update
    if @treino.update(treino_params)
      render json: @treino
    else
      render json: @treino.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treinos/:id
  def destroy
    @treino.destroy
    head :no_content
  end

  private

  def set_treino
    @treino = Treino.find(params[:id])
  end

  def treino_params
    params.require(:treino).permit(
      :aluno_id,
      :professor_id,
      :objetivo,
      :data_inicio,
      :data_fim,
      :observacoes)
  end
end