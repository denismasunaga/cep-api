class CreateCeps < ActiveRecord::Migration[6.1]
  def change
    create_table :ceps do |t|
      t.string :cep
      t.text :logradouro
      t.text :complemento
      t.string :bairro
      t.string :cidade
      t.string :uf

      t.timestamps
    end
  end
end
