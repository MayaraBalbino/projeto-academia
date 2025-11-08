class AlunosController < ApplicationController
  before_action :set_aluno, only: [:show, :edit, :update, :destroy]

  def index
    @alunos = Aluno.includes(:plano).page(params[:page]).per(10)
  end

  def new
    @aluno = Aluno.new
  end

  def create
    @aluno = Aluno.new(aluno_params)
    if @aluno.save
      redirect_to alunos_path, notice: 'Aluno cadastrado com sucesso.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @aluno.update(aluno_params)
      redirect_to alunos_path, notice: 'Aluno atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    begin
      @aluno.destroy
      redirect_to alunos_path, notice: 'Aluno deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to alunos_path, alert: '⚠️ Não é possível deletar este aluno porque ele tem pagamentos ou treinos vinculados.'
    end
  end

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

  def set_aluno
    @aluno = Aluno.find(params[:id])
  end

  def aluno_params
    params.require(:aluno).permit(:nome, :cpf, :email, :telefone, :data_nascimento, :status, :plano_id)
  end
end