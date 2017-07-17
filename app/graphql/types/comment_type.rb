CommentType = GraphQL::ObjectType.define do
  name "Comment"
  field :id, types.Int
  field :body, types.String
  field :author, UserType do
    resolve -> (obj, args, ctx) {
      RecordLoader.for(User).load(obj.author_id)
    }
  end
  field :post, PostType
end
