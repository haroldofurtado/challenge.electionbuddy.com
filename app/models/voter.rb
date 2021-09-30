# frozen_string_literal: true

class Voter < ApplicationRecord
  include Auditable

  audit_after_create
  audit_after_update
  audit_after_destroy

  belongs_to :election
end
