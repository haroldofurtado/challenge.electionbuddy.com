# frozen_string_literal: true

class Election < ApplicationRecord
  include Auditable

  audit_after_create
  audit_after_update
  audit_after_destroy

  has_many :questions
  belongs_to :user

  serialize :settings, Hash

  def visibility
    settings[:visibility]
  end

  def visibility=(value)
    settings[:visibility] = value
  end
end
