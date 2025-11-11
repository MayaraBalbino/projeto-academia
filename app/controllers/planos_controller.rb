require 'csv'

# CRUD completo de Planos de Academia
class PlanosController < ApplicationController
  before_action :set_plano, only: [:show, :edit, :update, :destroy]

  # Lista todos os planos com paginação, mais recentes primeiro
  def index
    @planos = Plano.order(created_at: :desc).page(params[:page]).per(10)
  end

  # Exibe formulário de novo plano
  def new
    @plano = Plano.new
  end

  # Cria novo plano
  def create
    @plano = Plano.new(plano_params)
    if @plano.save
      redirect_to planos_path, notice: 'Plano criado com sucesso.'
    else
      render :new
    end
  end

  # Exibe detalhes do plano
  def show
  end

  # Exibe formulário de edição
  def edit
  end

  # Atualiza dados do plano
  def update
    if @plano.update(plano_params)
      redirect_to planos_path, notice: 'Plano atualizado com sucesso.'
    else
      render :edit
    end
  end

  # Deleta plano (não permite se houver alunos usando)
  def destroy
    begin
      @plano.destroy
      redirect_to planos_path, notice: 'Plano deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to planos_path, alert: '⚠️ Não é possível deletar este plano porque ele está vinculado a alunos. Remova os alunos deste plano primeiro.'
    end
  end

  # Exporta todos os planos em PDF
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
end