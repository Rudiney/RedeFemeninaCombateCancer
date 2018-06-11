# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130928144819) do

  create_table "anexos", :force => true do |t|
    t.integer  "dono_id"
    t.string   "dono_type"
    t.string   "nome"
    t.string   "arquivo_file_name"
    t.string   "arquivo_content_type"
    t.integer  "arquivo_file_size"
    t.datetime "arquivo_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "convenios", :force => true do |t|
    t.string   "nome",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "data_do_cadastro"
    t.text     "observacao"
  end

  create_table "meios_contatos", :force => true do |t|
    t.string   "dono_type",  :null => false
    t.integer  "dono_id",    :null => false
    t.string   "tipo",       :null => false
    t.string   "valor",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "niveis_escolaridade", :force => true do |t|
    t.string   "nome",             :null => false
    t.date     "data_do_cadastro"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "observacao"
  end

  create_table "pacientes", :force => true do |t|
    t.string   "nome",                    :null => false
    t.date     "nascimento"
    t.string   "identidade"
    t.string   "cpf"
    t.text     "endereco"
    t.string   "cartao_sus"
    t.string   "tipo_de_cancer"
    t.datetime "obito"
    t.text     "observacao_obito"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.text     "local_nascimento"
    t.string   "raca"
    t.string   "profissao"
    t.text     "endereco_profissional"
    t.string   "estado_civil"
    t.string   "nome_conjuge"
    t.string   "profissao_conjuge"
    t.string   "contato_conjuge"
    t.boolean  "tem_filhos"
    t.integer  "quantidade_filhos"
    t.string   "idade_filhos"
    t.text     "diagnostico"
    t.text     "tratamentos"
    t.text     "acompanhamento_medico"
    t.text     "medicamentos_utilizados"
    t.text     "custo_manutencao_cancer"
    t.text     "atividades"
    t.text     "horario_disponibilidade"
    t.date     "data_do_cadastro"
    t.text     "observacao"
    t.integer  "escolaridade_id"
  end

  create_table "pacientes_produtos", :force => true do |t|
    t.integer  "paciente_id", :null => false
    t.integer  "produto_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pacientes_servicos", :force => true do |t|
    t.integer  "paciente_id", :null => false
    t.integer  "servico_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "produtos", :force => true do |t|
    t.string   "nome",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "data_do_cadastro"
    t.text     "observacao"
  end

  create_table "produtos_solicitacoes_produtos", :force => true do |t|
    t.integer  "produto_id",             :null => false
    t.integer  "solicitacao_produto_id", :null => false
    t.integer  "quantidade",             :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.date     "valido_ate"
  end

  create_table "profissionais", :force => true do |t|
    t.string   "nome",             :null => false
    t.integer  "servico_id",       :null => false
    t.string   "municipio"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "data_do_cadastro"
    t.text     "observacao"
  end

  create_table "profissionais_convenios", :force => true do |t|
    t.integer  "profissional_id", :null => false
    t.integer  "convenio_id",     :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "servicos", :force => true do |t|
    t.string   "nome",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "data_do_cadastro"
    t.text     "observacao"
  end

  create_table "solicitacoes_produtos", :force => true do |t|
    t.integer  "paciente_id",    :null => false
    t.date     "solicitado_dia", :null => false
    t.date     "entregue_dia"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "solicitacoes_servicos", :force => true do |t|
    t.integer  "paciente_id",     :null => false
    t.integer  "profissional_id", :null => false
    t.integer  "servico_id",      :null => false
    t.date     "data",            :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "hora"
  end

  create_table "tipos_voluntarias", :force => true do |t|
    t.string   "nome",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "data_do_cadastro"
    t.text     "observacao"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nome"
    t.boolean  "is_admin"
    t.date     "data_do_cadastro"
    t.text     "observacao"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "voluntarias", :force => true do |t|
    t.string   "nome",                                :null => false
    t.string   "cpf"
    t.string   "identidade"
    t.date     "nascimento",                          :null => false
    t.string   "local_de_nascimento"
    t.string   "estado_civil",                        :null => false
    t.string   "nome_do_esposo"
    t.string   "profissao"
    t.string   "endereco"
    t.text     "horario_para_contato"
    t.boolean  "atuante",                             :null => false
    t.datetime "ativada_em"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "tipo_voluntaria_id",   :default => 0, :null => false
    t.text     "areas_interesse"
    t.text     "sugestoes"
    t.date     "data_do_cadastro"
    t.text     "observacao"
    t.integer  "escolaridade_id"
  end

end
