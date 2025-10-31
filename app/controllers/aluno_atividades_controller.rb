class AlunoAtividadesController < ActionController::API
  before_action :set_aluno
  before_action :set_aluno_atividade, only: [:show, :update, :destroy]

  # GET /alunos/:aluno_id/atividades
  def index
    @atividades = @aluno.atividades_fisicas
    render json: @atividades
  end

  # GET /alunos/:aluno_id/atividades/:id
  def show
    render json: @aluno_atividade
  end

  # POST /alunos/:aluno_id/atividades
  def create
    @aluno_atividade = @aluno.aluno_atividades.new(aluno_atividade_params)
    if @aluno_atividade.save
      render json: @aluno_atividade, status: :created
    else
      render json: @aluno_atividade.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alunos/:aluno_id/atividades/:id
  def update
    if @aluno_atividade.update(aluno_atividade_params)
      render json: @aluno_atividade
    else
      render json: @aluno_atividade.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alunos/:aluno_id/atividades/:id
  def destroy
    @aluno_atividade.destroy
    head :no_content
  end

  private

  def set_aluno
    @aluno = Aluno.find(params[:aluno_id])
  end

  def set_aluno_atividade
    @aluno_atividade = @aluno.aluno_atividades.find(params[:id])
  end

  def aluno_atividade_params
    params.require(:aluno_atividade).permit(:atividade_fisica_id, :data_inicio, :data_fim, :dias_semana)
  end
end