require 'csv'

# CRUD completo de Pagamentos Mensais
class PagamentosController < ApplicationController
  before_action :set_pagamento, only: [:show, :edit, :update, :destroy]

  # Lista todos os pagamentos com paginação, mais recentes primeiro
  def index
    @pagamentos = Pagamento.order(created_at: :desc).page(params[:page]).per(10)
  end

  # Exibe formulário de novo pagamento
  def new
    @pagamento = Pagamento.new
  end

  # Cria novo pagamento
  def create
    @pagamento = Pagamento.new(pagamento_params)
    if @pagamento.save
      redirect_to pagamentos_path, notice: 'Pagamento criado com sucesso.'
    else
      render :new
    end
  end

  # Exibe detalhes do pagamento
  def show
  end

  # Exibe formulário de edição
  def edit
  end

  # Atualiza dados do pagamento
  def update
    if @pagamento.update(pagamento_params)
      redirect_to pagamentos_path, notice: 'Pagamento atualizado com sucesso.'
    else
      render :edit
    end
  end

  # Deleta pagamento
  def destroy
    begin
      @pagamento.destroy
      redirect_to pagamentos_path, notice: 'Pagamento deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to pagamentos_path, alert: '⚠️ Não é possível deletar este pagamento no momento.'
    end
  end

  # Exporta todos os pagamentos em PDF
  def export_pdf
    @pagamentos = Pagamento.includes(:aluno, :plano).all
    respond_to do |format|
      format.pdf do
        pdf = PdfTableExporter.generate(
          title: 'Relatório de Pagamentos',
          headers: ['ID', 'Aluno', 'Plano', 'Valor', 'Status', 'Vencimento', 'Pagamento', 'Forma Pgto', 'Referente a'],
          rows: @pagamentos.map do |pagamento|
            [
              pagamento.id,
              pagamento.aluno&.nome,
              pagamento.plano&.nome_plano,
              pagamento.valor ? "R$ #{format('%.2f', pagamento.valor)}" : '—',
              pagamento.status,
              pagamento.data_vencimento&.strftime('%d/%m/%Y') || '—',
              pagamento.data_pagamento&.strftime('%d/%m/%Y') || '—',
              pagamento.forma_pagamento || '—',
              pagamento.referente_a || '—'
            ]
          end
        )
        send_data pdf.render,
                  filename: "pagamentos_#{Date.today}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  # Retorna dados do aluno em JSON (usado no formulário para preencher plano e valor automaticamente)
  def aluno_data
    aluno = Aluno.includes(:plano).find(params[:id])
    render json: {
      plano_id: aluno.plano_id,
      plano_nome: aluno.plano&.nome_plano,
      valor: aluno.plano&.valor_mensal
    }
  end

  private

  def set_pagamento
    @pagamento = Pagamento.find(params[:id])
  end

  def pagamento_params
    params.require(:pagamento).permit(
      :aluno_id, :plano_id, :data_pagamento, :data_vencimento,
      :valor, :forma_pagamento, :referente_a, :status
    )
  end
end