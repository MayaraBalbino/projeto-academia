puts "🌱 Iniciando população do banco de dados..."

# Limpar dados existentes
puts "\n🧹 Limpando dados antigos..."
Treino.destroy_all
Aluno.destroy_all
Professor.destroy_all
Plano.destroy_all

# Criar Planos
puts "\n📋 Criando planos..."
planos = [
  { nome_plano: "Mensal", valor_mensal: 99.90, duracao_meses: 1 },
  { nome_plano: "Trimestral", valor_mensal: 89.90, duracao_meses: 3 },
  { nome_plano: "Anual", valor_mensal: 79.90, duracao_meses: 12 }
]

planos_criados = planos.map { |p| Plano.create!(p) }
puts "✅ #{planos_criados.count} planos criados"

# Criar Professores
puts "\n🎓 Criando professores..."
professores_data = [
  { nome: "Carlos Silva", especialidade: "Musculação", email: "carlos@gmail.com", data_contratacao: 2.years.ago, salario: 3500.00 },
  { nome: "Ana Paula Santos", especialidade: "Crossfit", email: "anapaula@gmail.com", data_contratacao: 1.year.ago, salario: 3800.00 },
  { nome: "Roberto Oliveira", especialidade: "Funcional", email: "roberto@gmail.com", data_contratacao: 3.years.ago, salario: 4000.00 },
  { nome: "Juliana Costa", especialidade: "Yoga", email: "juliana@gmail.com", data_contratacao: 6.months.ago, salario: 3200.00 },
  { nome: "Fernando Lima", especialidade: "Personal Trainer", email: "fernando@gmail.com", data_contratacao: 4.years.ago, salario: 4500.00 }
]

professores_criados = professores_data.map { |p| Professor.create!(p) }
puts "✅ #{professores_criados.count} professores criados"

# Criar Alunos
puts "\n👥 Criando alunos..."
alunos_data = [
  { nome: "João Pedro Alves", email: "joaopedro@gmail.com", telefone: "(11) 98765-4321", data_nascimento: 25.years.ago, cpf: "123.456.789-01" },
  { nome: "Maria Eduarda Lima", email: "mariaeduarda@gmail.com", telefone: "(11) 98765-4322", data_nascimento: 28.years.ago, cpf: "123.456.789-02" },
  { nome: "Lucas Gabriel Santos", email: "lucasgabriel@gmail.com", telefone: "(11) 98765-4323", data_nascimento: 22.years.ago, cpf: "123.456.789-03" },
  { nome: "Ana Clara Oliveira", email: "anaclara@gmail.com", telefone: "(11) 98765-4324", data_nascimento: 30.years.ago, cpf: "123.456.789-04" },
  { nome: "Pedro Henrique Costa", email: "pedrohenrique@gmail.com", telefone: "(11) 98765-4325", data_nascimento: 35.years.ago, cpf: "123.456.789-05" },
  { nome: "Beatriz Souza", email: "beatriz@gmail.com", telefone: "(11) 98765-4326", data_nascimento: 27.years.ago, cpf: "123.456.789-06" },
  { nome: "Rafael Martins", email: "rafael@gmail.com", telefone: "(11) 98765-4327", data_nascimento: 24.years.ago, cpf: "123.456.789-07" },
  { nome: "Larissa Fernandes", email: "larissa@gmail.com", telefone: "(11) 98765-4328", data_nascimento: 29.years.ago, cpf: "123.456.789-08" },
  { nome: "Gustavo Rodrigues", email: "gustavo@gmail.com", telefone: "(11) 98765-4329", data_nascimento: 32.years.ago, cpf: "123.456.789-09" },
  { nome: "Camila Pereira", email: "camila@gmail.com", telefone: "(11) 98765-4330", data_nascimento: 26.years.ago, cpf: "123.456.789-10" },
  { nome: "Bruno Henrique Silva", email: "brunohenrique@gmail.com", telefone: "(11) 98765-4331", data_nascimento: 31.years.ago, cpf: "123.456.789-11" },
  { nome: "Fernanda Alves", email: "fernanda@gmail.com", telefone: "(11) 98765-4332", data_nascimento: 23.years.ago, cpf: "123.456.789-12" },
  { nome: "Rodrigo Carvalho", email: "rodrigo@gmail.com", telefone: "(11) 98765-4333", data_nascimento: 28.years.ago, cpf: "123.456.789-13" },
  { nome: "Juliana Mendes", email: "julianamendes@gmail.com", telefone: "(11) 98765-4334", data_nascimento: 25.years.ago, cpf: "123.456.789-14" },
  { nome: "Thiago Barbosa", email: "thiago@gmail.com", telefone: "(11) 98765-4335", data_nascimento: 33.years.ago, cpf: "123.456.789-15" },
  { nome: "Isabela Rocha", email: "isabela@gmail.com", telefone: "(11) 98765-4336", data_nascimento: 27.years.ago, cpf: "123.456.789-16" },
  { nome: "Felipe Araújo", email: "felipe@gmail.com", telefone: "(11) 98765-4337", data_nascimento: 29.years.ago, cpf: "123.456.789-17" },
  { nome: "Natália Ribeiro", email: "natalia@gmail.com", telefone: "(11) 98765-4338", data_nascimento: 24.years.ago, cpf: "123.456.789-18" },
  { nome: "Daniel Sousa", email: "daniel@gmail.com", telefone: "(11) 98765-4339", data_nascimento: 30.years.ago, cpf: "123.456.789-19" },
  { nome: "Patrícia Gomes", email: "patricia@gmail.com", telefone: "(11) 98765-4340", data_nascimento: 26.years.ago, cpf: "123.456.789-20" }
]

alunos_criados = alunos_data.map do |aluno_data|
  Aluno.create!(aluno_data.merge(plano: planos_criados.sample))
end
puts "✅ #{alunos_criados.count} alunos criados"

# Criar Treinos
puts "\n🏋️ Criando treinos..."
objetivos = ["Emagrecimento", "Hipertrofia", "Condicionamento Físico"]

3.times do |i|
  Treino.create!(
    aluno: alunos_criados.sample,
    professor: professores_criados.sample,
    objetivo: objetivos[i]
  )
end
puts "✅ 3 treinos criados"

puts "\n✨ Banco de dados populado com sucesso!"
puts "📊 Resumo:"
puts "   - #{Plano.count} planos"
puts "   - #{Professor.count} professores"
puts "   - #{Aluno.count} alunos"
puts "   - #{Treino.count} treinos"
