# CRUD completo de Alunos
class AlunosController < ApplicationController
  before_action :set_aluno, only: [:show, :edit, :update, :destroy]

  # Lista todos os alunos com paginação (10 por página), mais recentes primeiro
  def index
    @alunos = Aluno.includes(:plano).order(created_at: :desc).page(params[:page]).per(10)
  end

  # Exibe formulário de novo aluno
  def new
    @aluno = Aluno.new
  end

  # Cria novo aluno no banco
  def create
    @aluno = Aluno.new(aluno_params)
    if @aluno.save
      redirect_to alunos_path, notice: 'Aluno cadastrado com sucesso.'
    else
      render :new
    end
  end

  # Exibe detalhes de um aluno
  def show
  end

  # Exibe formulário de edição
  def edit
  end

  # Atualiza dados do aluno
  def update
    if @aluno.update(aluno_params)
      redirect_to alunos_path, notice: 'Aluno atualizado com sucesso.'
    else
      render :edit
    end
  end

  # Deleta aluno (com proteção para foreign keys)
  def destroy
    begin
      @aluno.destroy
      redirect_to alunos_path, notice: 'Aluno deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to alunos_path, alert: '⚠️ Não é possível deletar este aluno porque ele tem pagamentos ou treinos vinculados.'
    end
  end

  # Exporta todos os alunos em PDF
  def export_pdf
    @alunos = Aluno.includes(:plano).all
    respond_to do |format|
      format.pdf do
        pdf = PdfTableExporter.generate(
          title: 'Relatório de Alunos',
          headers: ['ID', 'Nome', 'CPF', 'Plano', 'Telefone', 'Status'],
          rows: @alunos.map do |aluno|
            [
              aluno.id,
              aluno.nome,
              aluno.cpf,
              aluno.plano&.nome_plano,
              aluno.telefone,
              aluno.status
            ]
          end
        )
        send_data pdf.render,
                  filename: "alunos_#{Date.today}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  private

  # Busca aluno pelo ID
  def set_aluno
    @aluno = Aluno.find(params[:id])
  end

  # Define parâmetros permitidos para criar/atualizar aluno
  def aluno_params
    params.require(:aluno).permit(:nome, :cpf, :email, :telefone, :data_nascimento, :status, :plano_id)
  end
end