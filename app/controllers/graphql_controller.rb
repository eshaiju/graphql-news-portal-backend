class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    document = get_document(query)

    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = HackerNewsSchema.execute(document: document, variables: variables, context: context)
    render json: result
  end

  private

   def get_document(query_string)
    cache_key = Base64.encode64(query_string)
    document = Rails.cache.fetch(cache_key)

    if document
      logger.info "###############################"
      logger.info "Got cached document #{document}"
      logger.info "###############################"
    else
      logger.info "####################################"
      logger.info "Parsing query string #{query_string}"
      logger.info "Cached at key #{cache_key}"
      logger.info "####################################"

      document = GraphQL.parse(query_string)
      Rails.cache.write(cache_key, document)
    end

    document
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
