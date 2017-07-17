HackerNewsSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType

  use GraphQL::Batch
end

HackerNewsSchema.middleware << GraphQL::Schema::TimeoutMiddleware.new(max_seconds: 10) do |err, query|
  Rails.logger.info("GraphQL Timeout: #{query.query_string}")
end
