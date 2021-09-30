# frozen_string_literal: true

class Answer < ApplicationRecord
  include Auditable

  audit_after_create
  audit_after_update
  audit_after_destroy

  belongs_to :question
end
