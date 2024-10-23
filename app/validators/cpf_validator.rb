class CpfValidator < ActiveModel::Validator
  def validate(record)
    unless CPF.valid?(record.cpf)
      record.errors.add :cpf, "inválido"
    end
  end
end