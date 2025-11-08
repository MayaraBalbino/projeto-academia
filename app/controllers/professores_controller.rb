require 'csv'

class ProfessoresController < ApplicationController
  before_action :set_professor, only: [:show, :edit, :update, :destroy]

  def index
    @professores = Professor.page(params[:page]).per(10)
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      redirect_to professores_path, notice: 'Professor cadastrado com sucesso.'
    else
      flash.now[:alert] = "Erro ao cadastrar professor: #{@professor.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @professor.update(professor_params)
      redirect_to professores_path, notice: 'Professor atualizado com sucesso.'
    else
      flash.now[:alert] = "Erro ao atualizar professor: #{@professor.errors.full_messages.join(', ')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @professor.destroy
      redirect_to professores_path, notice: 'Professor deletado com sucesso.'
    rescue ActiveRecord::InvalidForeignKey
      redirect_to professores_path, alert: '⚠️ Não é possível deletar este professor porque ele está vinculado a treinos. Remova os treinos deste professor primeiro.'
    end
  end

  def export_csv
    @professores = Professor.all
    respond_to do |format|
      format.csv { 
        send_data csv_professores, filename: "professores_#{Date.today}.csv"
      }
    end
  end

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

  def csv_professores
    CSV.generate(headers: true) do |csv|
      csv << ['ID', 'Nome', 'Especialidade', 'Email']
      Professor.all.each do |prof|
        csv << [prof.id, prof.nome, prof.especialidade, prof.email]
      end
    end
  end
end