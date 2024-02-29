# frozen_string_literal: true

module LanguageModel
  module Api
    module LoadBalancer
      # LanguageModel::Api::LoadBalancer::RoundRobinService
      class RoundRobinService
        def process
          return nil if servers.empty?

          current_index = next_index(servers.size)
          servers[current_index]
        end

        private

        def servers
          @servers ||= Server.all
        end

        def next_index(size)
          index = Rails.cache.read(redis_key)
          index = index.nil? ? 0 : (index + 1) % size
          Rails.cache.write(redis_key, index)
          index
        end

        def redis_key
          @redis_key ||= ENV.fetch('REDIS_ROUND_ROBIN_INDEX', 'round_robin_index')
        end
      end
    end
  end
end
