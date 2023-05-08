class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :full_name, :email, :created_at
end
