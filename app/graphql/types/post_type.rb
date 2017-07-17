PostType = GraphQL::ObjectType.define do
  name "Post"
  description "Post and details"

  field :id, types.Int
  field :title, types.String
  field :body, types.String
  field :url, types.String

  field :published_at, types.String do
    resolve -> (post, args, ctx) { post.published_at }
  end

  field :votes, types.Int

  field :comments, types[CommentType] do
    resolve -> (post, args, ctx) { post.comments.order(id: :desc) }
  end

  field :author, UserType do
    resolve -> (obj, args, ctx) {
      RecordLoader.for(User).load(obj.author_id)
    }
  end

  field :latest_comments,types[CommentType] do
    resolve -> (post, args, ctx) { post.comments.order(id: :desc).limit(5) }
  end
end
