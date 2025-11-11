require 'csv'

# CRUD completo de Professores
class ProfessoresController < ApplicationController
  before_action :set_professor, only: [:show, :edit, :update, :destroy]

  # Lista todos os professores com paginação, mais recentes primeiro
  def index
    @professores = Professor.order(created_at: :desc).page(params[:page]).per(10)
  end

  # Exibe formulário de novo professor
  def new
    @professor = Professor.new
  end

  # Cria novo professor
  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      redirect_to professores_path, notice: 'Professor cadastrado com sucesso.'
    else
      flash.now[:alert] = "Erro ao cadastrar professor: #{@professor.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  # Exibe detalhes do professor
  def show
  end

  # Exibe formulário de edição
  def edit
  end

  # Atualiza dados do professor
  def update
    if @professor.update(professor_params)
      redirect_to professores_path, notice: 'Professor atualizado com sucesso.'
    else
      flash.now[:alert] = "Erro ao atualizar professor: #{@professor.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  # Deleta professor (não permite se tiver treinos vinculados)
  def destroy
    begin
      @professor.destroy
      redirect_to professores_path, notice: 'Professor deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to professores_path, alert: '⚠️ Não é possível deletar este professor porque ele está vinculado a treinos. Remova os treinos deste professor primeiro.'
    end
  end

  # Exporta todos os professores em PDF
  def export_pdf
    @professores = Professor.all
    respond_to do |format|
      format.pdf do
        pdf = PdfTableExporter.generate(
          title: 'Relatório de Professores',
          headers: ['ID', 'Nome', 'Especialidade', 'Email', 'Telefone', 'Data Contratação', 'Salário'],
          rows: @professores.map do |prof|
            [
              prof.id,
              prof.nome,
              prof.especialidade,
              prof.email,
              prof.telefone,
              prof.data_contratacao&.strftime('%d/%m/%Y') || '—',
              prof.salario ? "R$ #{format('%.2f', prof.salario)}" : '—'
            ]
          end
        )
        send_data pdf.render,
                  filename: "professores_#{Date.today}.pdf",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  private

  def set_professor
    @professor = Professor.find(params[:id])
  end

  def professor_params
    params.require(:professor).permit(:nome, :cpf, :email, :telefone, :especialidade, :data_contratacao, :salario)
  end
end