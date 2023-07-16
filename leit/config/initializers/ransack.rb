# frozen_string_literal: true

require 'ransack'

module Ransack
  module Naming
    def model_name
      self.class.model_name
    end
  end
end
