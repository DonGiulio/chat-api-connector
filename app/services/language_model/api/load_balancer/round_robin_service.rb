# frozen_string_literal: true

module LanguageModel
  module Api
    module LoadBalancer
      # LanguageModel::Api::LoadBalancer::RoundRobinService
      class RoundRobinService
        def process
          'http://35.204.143.204:5000/v1/chat/completions'
        end
      end
    end
  end
end
