# frozen_string_literal: true
require 'active_model'

class Genre
  extend ActiveModel::Naming if defined?(ActiveModel::Naming)
  include ActiveModel::Conversion if defined?(ActiveModel::Conversion)

  def to_label
  end

  def persisted?
  end
end
