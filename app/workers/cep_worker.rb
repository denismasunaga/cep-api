class CepWorker
  include Sidekiq::Worker

  def perform(cep)
    Cep.create!(cep)
  end
end
