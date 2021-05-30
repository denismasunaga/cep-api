class CepDecorator < ApplicationDecorator
  delegate_all

  def full_address
    complemento = object.complemento.present? ? "#{object.complemento}, " : ''
    "#{object.logradouro}, #{complemento}#{object.bairro}, #{object.cidade}, #{object.uf}"
  end

end
