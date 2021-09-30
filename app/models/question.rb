# frozen_string_literal: true

class Question < ApplicationRecord
  include Auditable

  audit_after_create
  audit_after_update
  audit_after_destroy

  belongs_to :election
  has_many :answers
end
