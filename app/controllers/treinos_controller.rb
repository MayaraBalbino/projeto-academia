require 'csv'

class TreinosController < ApplicationController
  before_action :set_treino, only: [:show, :edit, :update, :destroy]

  def index
    @treinos = Treino.page(params[:page]).per(10)
  end

  def new
    @treino = Treino.new
  end

  def create
    @treino = Treino.new(treino_params)
    if @treino.save
      redirect_to treinos_path, notice: 'Treino criado com sucesso.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @treino.update(treino_params)
      redirect_to treinos_path, notice: 'Treino atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    begin
      @treino.destroy
      redirect_to treinos_path, notice: 'Treino deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to treinos_path, alert: '⚠️ Não é possível deletar este treino no momento.'
    end
  end

  def export_csv
    @treinos = Treino.all
    respond_to do |format|
      format.csv { 
        send_data csv_treinos, filename: "treinos_#{Date.today}.csv"
      }
    end
  end

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

  def csv_treinos
    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Aluno', 'Professor', 'Objetivo', 'Data Início']
      Treino.all.each do |treino|
        csv << [treino.id, treino.aluno&.nome, treino.professor&.nome, treino.objetivo, treino.data_inicio]
      end
    end
  end
end