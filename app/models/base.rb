# frozen_string_literal: true

class Base
  include ActiveModel::Validations

  # push current and associated objects errors
  def push_errors
    [].tap do |error|
      error.push(errors.full_messages) unless valid?
      self.class::ASSOCIATIONS.each do |attr|
        error.push(send(attr).errors.full_messages) unless send(attr).valid?
      end
    end
  end
end
