class Invitation < ApplicationRecord
  belongs_to :sender, foreign_key: "group_from_id", class_name: "Group"
  belongs_to :receiver, foreign_key: "group_to_id", class_name: "Group"
  has_many :agree_on_invitations
  has_many :agree_users, through: :agree_on_invitations, source: :user
  has_many :disagree_on_invitations
  has_many :disagree_users, through: :disagree_on_invitations, source: :user
end
