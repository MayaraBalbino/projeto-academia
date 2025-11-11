require 'csv'

# CRUD completo de Treinos (vincula Aluno + Professor)
class TreinosController < ApplicationController
  before_action :set_treino, only: [:show, :edit, :update, :destroy]

  # Lista todos os treinos com paginação, mais recentes primeiro
  def index
    @treinos = Treino.order(created_at: :desc).page(params[:page]).per(10)
  end

  # Exibe formulário de novo treino
  def new
    @treino = Treino.new
  end

  # Cria novo treino
  def create
    @treino = Treino.new(treino_params)
    if @treino.save
      redirect_to treinos_path, notice: 'Treino criado com sucesso.'
    else
      render :new
    end
  end

  # Exibe detalhes do treino
  def show
  end

  # Exibe formulário de edição
  def edit
  end

  # Atualiza dados do treino
  def update
    if @treino.update(treino_params)
      redirect_to treinos_path, notice: 'Treino atualizado com sucesso.'
    else
      render :edit
    end
  end

  # Deleta treino
  def destroy
    begin
      @treino.destroy
      redirect_to treinos_path, notice: 'Treino deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to treinos_path, alert: '⚠️ Não é possível deletar este treino no momento.'
    end
  end

  # Exporta todos os treinos em PDF
  def export_pdf
    @treinos = Treino.includes(:aluno, :professor).all
    respond_to do |format|
      format.pdf do
        pdf = PdfTableExporter.generate(
          title: 'Relatório de Treinos',
          headers: ['ID', 'Aluno', 'Professor', 'Objetivo', 'Início', 'Fim', 'Observações'],
          rows: @treinos.map do |treino|
            [
              treino.id,
              treino.aluno&.nome,
              treino.professor&.nome,
              treino.objetivo,
              treino.data_inicio&.strftime('%d/%m/%Y') || '—',
              treino.data_fim&.strftime('%d/%m/%Y') || '—',
              treino.observacoes || '—'
            ]
          end
        )
        send_data pdf.render,
                  filename: "treinos_#{Date.today}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  private

  def set_treino
    @treino = Treino.find(params[:id])
  end

  def treino_params
    params.require(:treino).permit(
      :aluno_id, :professor_id, :objetivo, :data_inicio, :data_fim, :observacoes
    )
  end
end