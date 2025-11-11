require 'csv'

# Gerencia a dashboard (página inicial) e exportação geral em CSV
class HomeController < ApplicationController
  def index
    # Apenas renderiza a view com os cards - não precisa carregar dados
  end

  # Exporta TODOS os dados do sistema em um único arquivo CSV
  def export_dashboard_csv
    csv_data = "\xEF\xBB\xBF" + dashboard_csv
    send_data csv_data,
              filename: "dashboard_#{Date.today}.csv",
              type: 'text/csv; charset=utf-8',
              disposition: 'attachment'
  end

  private

  # Gera CSV com todas as seções (Alunos, Professores, Planos, Pagamentos, Treinos)
  def dashboard_csv
    CSV.generate(col_sep: ';', encoding: 'UTF-8') do |csv|
      append_section(csv, 'Alunos', %w[ID Nome Email CPF Telefone DataNascimento Status Plano]) do
        Aluno.includes(:plano).find_each do |aluno|
          csv << [
            aluno.id,
            aluno.nome,
            aluno.email,
            format_cpf(aluno.cpf),
            format_telefone(aluno.telefone),
            aluno.data_nascimento&.strftime('%d/%m/%Y'),
            aluno.status,
            aluno.plano&.nome_plano
          ]
        end
      end

      append_section(csv, 'Professores', %w[ID Nome CPF Email Telefone Especialidade DataContratacao Salario]) do
        Professor.find_each do |prof|
          csv << [
            prof.id,
            prof.nome,
            format_cpf(prof.cpf),
            prof.email,
            format_telefone(prof.telefone),
            prof.especialidade,
            prof.data_contratacao&.strftime('%d/%m/%Y'),
            prof.salario ? format('%.2f', prof.salario) : ''
          ]
        end
      end

      append_section(csv, 'Planos', %w[ID Nome Descricao ValorMensal DuracaoMeses]) do
        Plano.find_each do |plano|
          csv << [
            plano.id,
            plano.nome_plano,
            plano.descricao,
            plano.valor_mensal ? format('%.2f', plano.valor_mensal) : '',
            plano.duracao_meses
          ]
        end
      end

      append_section(csv, 'Pagamentos', %w[ID Aluno Plano Valor Status DataVencimento DataPagamento FormaPagamento ReferenteA]) do
        Pagamento.includes(:aluno, :plano).find_each do |pagamento|
          csv << [
            pagamento.id,
            pagamento.aluno&.nome,
            pagamento.plano&.nome_plano,
            pagamento.valor ? format('%.2f', pagamento.valor) : '',
            pagamento.status,
            pagamento.data_vencimento&.strftime('%d/%m/%Y'),
            pagamento.data_pagamento&.strftime('%d/%m/%Y'),
            pagamento.forma_pagamento,
            pagamento.referente_a
          ]
        end
      end

      append_section(csv, 'Treinos', %w[ID Aluno Professor Objetivo DataInicio DataFim Observacoes]) do
        Treino.includes(:aluno, :professor).find_each do |treino|
          csv << [
            treino.id,
            treino.aluno&.nome,
            treino.professor&.nome,
            treino.objetivo,
            treino.data_inicio&.strftime('%d/%m/%Y'),
            treino.data_fim&.strftime('%d/%m/%Y'),
            treino.observacoes
          ]
        end
      end
    end
  end

  # Adiciona uma seção no CSV com título e cabeçalhos
  def append_section(csv, title, headers)
    csv << [title]
    csv << headers
    yield
    csv << []
  end

  # Formata CPF para exibição no Excel sem perder zeros à esquerda
  def format_cpf(cpf)
    return '' unless cpf.present?
    cpf = cpf.to_s.gsub(/\D/, '')
    return "=\"#{cpf}\"" if cpf.length != 11
    "=\"#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}\""
  end

  # Formata telefone para exibição no Excel
  def format_telefone(telefone)
    return '' unless telefone.present?
    "=\"#{telefone}\""
  end
end
