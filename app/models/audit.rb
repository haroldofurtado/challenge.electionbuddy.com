class Audit < ApplicationRecord
  belongs_to :auditable, polymorphic: true

  validates :action, presence: true
end
