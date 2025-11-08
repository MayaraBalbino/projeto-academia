# Destruir em ordem de dependência (tabelas dependentes primeiro)
Treino.destroy_all
Pagamento.destroy_all
Aluno.destroy_all
Professor.destroy_all
Plano.destroy_all

puts "Criando planos..."

plano_basico = Plano.create!(
  nome_plano: "Plano Básico",
  descricao: "Acesso a musculação, 2x por semana.",
  valor_mensal: 100.00,
  duracao_meses: 12
)

plano_premium = Plano.create!(
  nome_plano: "Plano Premium",
  descricao: "Acesso total a musculação e todas as aulas.",
  valor_mensal: 150.00,
  duracao_meses: 12
)

plano_diario = Plano.create!(
  nome_plano: "Plano Diário",
  descricao: "Acesso avulso.",
  valor_mensal: 30.00,
  duracao_meses: 1
)

puts "Criando professores..."

Professor.create!(
  nome: "Carlos Silva",
  cpf: "111.111.111-11",
  email: "carlos@academia.com",
  telefone: "(11) 98765-4321",
  especialidade: "Musculação",
  data_contratacao: Date.today,
  salario: 3500.00
)

Professor.create!(
  nome: "Ana Costa",
  cpf: "222.222.222-22",
  email: "ana@academia.com",
  telefone: "(11) 99876-5432",
  especialidade: "Yoga",
  data_contratacao: Date.today,
  salario: 2800.00
)

puts "Criando aluno de teste..."

aluno = Aluno.new(
  nome: "João Silva",
  cpf: "123.456.789-00",
  email: "joao@teste.com",
  telefone: "(11) 98765-1234",
  data_nascimento: Date.new(2000, 5, 15),
  status: "ativo",
  plano_id: plano_basico.id,
  jti: SecureRandom.uuid
)
aluno.password = "senha123"
aluno.password_confirmation = "senha123"
aluno.save!

puts "✓ Plano Básico (ID: #{plano_basico.id})"
puts "✓ Plano Premium (ID: #{plano_premium.id})"
puts "✓ Plano Diário (ID: #{plano_diario.id})"
puts "✓ Professores criados com sucesso!"
puts "✓ Aluno de teste criado:"
puts "  Email: joao@teste.com"
puts "  Senha: senha123"