class Invitation < ApplicationRecord
  belongs_to :sender, foreign_key: "group_from_id", class_name: "Group"
  belongs_to :receiver, foreign_key: "group_to_id", class_name: "Group"
end
