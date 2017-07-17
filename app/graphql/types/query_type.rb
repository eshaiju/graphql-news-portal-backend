QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :post do
    type PostType
    description "Find a Post by ID"

    argument :id, !types.ID
    resolve ->(obj, args, ctx) { Post.find_by_id(args[:id]) }
  end

  field :posts, types[PostType] do
    description "Return latest 10 posts"

    resolve ->(obj, args, ctx) { Post.order(id: :desc) }
  end

  field :latest_posts, types[PostType] do
    description "Return latest 10 posts"
    argument :limit, types.Int, default_value: 10
    resolve ->(obj, args, ctx) { Post.order(id: :desc).limit(10) }
  end

  field :users, types[UserType] do
    description "Fetch all users"

    resolve ->(obj, args, ctx) { User.all }
  end

  field :user do
    type UserType
    description "Find a User by ID"

    argument :id, !types.ID
    resolve ->(obj, args, ctx) { User.find_by_id(args[:id]) }
  end
end
