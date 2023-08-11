# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def error_sentence
    errors.full_messages.to_sentence
  end
end
