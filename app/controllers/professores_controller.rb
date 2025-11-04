class ProfessoresController < ActionController::API
  before_action :set_professor, only: [:show, :update, :destroy]

  # GET /professores
  def index
    @professores = Professor.all
    render json: @professores
  end

  # GET /professores/:id
  def show
    render json: @professor
  end

  # POST /professores
  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      render json: @professor, status: :created
    else
      render json: { errors: @professor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /professores/:id
  def update
    if @professor.update(professor_params)
      render json: @professor
    else
      render json: @professor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /professores/:id
  def destroy
    @professor.destroy
    head :no_content
  end

  private

  def set_professor
    @professor = Professor.find(params[:id])
  end

  def professor_params
    params.require(:professor).permit(
      :nome,
      :cpf,
      :telefone,
      :email,
      :especialidade,
      :data_contratacao,
      :salario)
  end
end