# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_10_31_004855) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "aluno_atividades", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.bigint "atividade_fisica_id", null: false
    t.datetime "created_at", null: false
    t.date "data_fim"
    t.date "data_inicio"
    t.string "dias_semana"
    t.datetime "updated_at", null: false
    t.index ["aluno_id"], name: "index_aluno_atividades_on_aluno_id"
    t.index ["atividade_fisica_id"], name: "index_aluno_atividades_on_atividade_fisica_id"
  end

  create_table "alunos", force: :cascade do |t|
    t.string "cpf", null: false
    t.datetime "created_at", null: false
    t.date "data_nascimento"
    t.string "email", null: false
    t.string "nome", null: false
    t.bigint "plano_id", null: false
    t.string "status", default: "ativo"
    t.string "telefone"
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_alunos_on_cpf", unique: true
    t.index ["email"], name: "index_alunos_on_email", unique: true
    t.index ["plano_id"], name: "index_alunos_on_plano_id"
  end

  create_table "atividade_fisicas", force: :cascade do |t|
    t.integer "calorias_estimadas"
    t.datetime "created_at", null: false
    t.text "descricao"
    t.integer "duracao_minutos"
    t.string "nivel_dificuldade"
    t.string "nome_atividade"
    t.bigint "professor_id", null: false
    t.datetime "updated_at", null: false
    t.index ["professor_id"], name: "index_atividade_fisicas_on_professor_id"
  end

  create_table "pagamentos", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.datetime "created_at", null: false
    t.date "data_pagamento"
    t.date "data_vencimento"
    t.string "forma_pagamento"
    t.bigint "plano_id", null: false
    t.string "referente_a"
    t.string "status"
    t.datetime "updated_at", null: false
    t.decimal "valor"
    t.index ["aluno_id"], name: "index_pagamentos_on_aluno_id"
    t.index ["plano_id"], name: "index_pagamentos_on_plano_id"
  end

  create_table "planos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "descricao"
    t.integer "duracao_meses", null: false
    t.string "nome_plano", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_mensal", precision: 10, scale: 2, null: false
  end

  create_table "professors", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", null: false
    t.date "data_contratacao"
    t.string "email"
    t.string "especialidade"
    t.string "nome"
    t.decimal "salario"
    t.string "telefone"
    t.datetime "updated_at", null: false
  end

  create_table "treinos", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.datetime "created_at", null: false
    t.date "data_fim"
    t.date "data_inicio"
    t.string "objetivo"
    t.text "observacoes"
    t.bigint "professor_id", null: false
    t.datetime "updated_at", null: false
    t.index ["aluno_id"], name: "index_treinos_on_aluno_id"
    t.index ["professor_id"], name: "index_treinos_on_professor_id"
  end

  add_foreign_key "aluno_atividades", "alunos"
  add_foreign_key "aluno_atividades", "atividade_fisicas"
  add_foreign_key "alunos", "planos"
  add_foreign_key "atividade_fisicas", "professors"
  add_foreign_key "pagamentos", "alunos"
  add_foreign_key "pagamentos", "planos"
  add_foreign_key "treinos", "alunos"
  add_foreign_key "treinos", "professors"
end
