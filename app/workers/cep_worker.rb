class CepWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(cep)
    Cep.create!(cep)
  end
end
