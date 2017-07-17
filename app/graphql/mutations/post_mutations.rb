# encoding: utf-8
module PostMutations
  Create = GraphQL::Relay::Mutation.define do
    name "Create Post"

    # Define input parameters
    input_field :title, !types.String
    input_field :url, !types.String

    # Define return parameters
    return_field :post, PostType
    return_field :errors, types.String


    resolve ->(object, inputs, ctx) {
      post = Post.new(title: inputs[:title], url: inputs[:url], published_at: Time.now, author_id: User.first.id)
      if post.save
        { post: post }
      else
        { errors: post.errors.to_a }
      end
    }
  end
end
