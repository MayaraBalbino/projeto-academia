require 'csv'

class PlanosController < ApplicationController
  before_action :set_plano, only: [:show, :edit, :update, :destroy]

  def index
    @planos = Plano.page(params[:page]).per(10)
  end

  def new
    @plano = Plano.new
  end

  def create
    @plano = Plano.new(plano_params)
    if @plano.save
      redirect_to planos_path, notice: 'Plano criado com sucesso.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @plano.update(plano_params)
      redirect_to planos_path, notice: 'Plano atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    begin
      @plano.destroy
      redirect_to planos_path, notice: 'Plano deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to planos_path, alert: '⚠️ Não é possível deletar este plano porque ele está vinculado a alunos. Remova os alunos deste plano primeiro.'
    end
  end

  def export_csv
    @planos = Plano.all
    respond_to do |format|
      format.csv { 
        send_data csv_planos, filename: "planos_#{Date.today}.csv"
      }
    end
  end

  def export_pdf
    @planos = Plano.all
    respond_to do |format|
      format.pdf do
        pdf = PdfTableExporter.generate(
          title: 'Relatório de Planos',
          headers: ['ID', 'Nome', 'Descrição', 'Duração (meses)', 'Valor mensal'],
          rows: @planos.map do |plano|
            [
              plano.id,
              plano.nome_plano,
              plano.descricao,
              plano.duracao_meses,
              plano.valor_mensal
            ]
          end
        )
        send_data pdf.render,
                  filename: "planos_#{Date.today}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  private

  def set_plano
    @plano = Plano.find(params[:id])
  end

  def plano_params
    params.require(:plano).permit(:nome_plano, :descricao, :valor_mensal, :duracao_meses)
  end

  def csv_planos
    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Nome do Plano', 'Valor Mensal', 'Duração']
      Plano.all.each do |plano|
        csv << [plano.id, plano.nome_plano, plano.valor_mensal, plano.duracao_meses]
      end
    end
  end
end