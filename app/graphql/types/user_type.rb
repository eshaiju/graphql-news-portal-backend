UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, types.Int
  field :name, types.String
  field :joined_at, types.String do
    resolve -> (user, args, ctx) { user.joined_at.strftime('%d %b %Y %H %M %p') }
  end

  field :comments, types[CommentType] do
    resolve -> (user, args, ctx) { Comment.where(author_id: user.id) }
  end
end
