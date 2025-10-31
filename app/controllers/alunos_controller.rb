class AlunosController < ActionController::API
  before_action :set_aluno, only: [:show, :update, :destroy]

  # GET /alunos
  def index
    @alunos = Aluno.all
    render json: @alunos
  end

  # GET /alunos/:id
  def show
    render json: @aluno
  end

  # POST /alunos
  def create
    @aluno = Aluno.new(aluno_params)
    if @aluno.save
      render json: @aluno, status: :created
    else
      render json: @aluno.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alunos/:id
  def update
    if @aluno.update(aluno_params)
      render json: @aluno
    else
      render json: @aluno.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alunos/:id
  def destroy
    @aluno.destroy
    head :no_content
  end

  private

  def set_aluno
    @aluno = Aluno.find(params[:id])
  end

  def aluno_params
    params.require(:aluno).permit(:nome, :cpf, :email, :telefone, :data_nascimento, :status, :plano_id)
  end


end