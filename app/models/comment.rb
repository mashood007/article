class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  default_scope { order("created_at DESC")}
end
