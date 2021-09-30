# frozen_string_literal: true

module Auditable
  extend ActiveSupport::Concern

  class_methods do
    def audit_after_create
      after_create :audit_after_create
    end

    def audit_after_update
      after_update :audit_after_update
    end

    def audit_after_destroy
      after_destroy :audit_after_destroy
    end
  end

  included do
    attr_accessor :responsible_user

    has_many :audits, as: :auditable
  end

  private

  def audit_after_create
    input = {
      auditable: self,
      content: attributes,
      responsible_user: responsible_user.try(:email),
      action: :create
    }
    Audit.create(input)
  end

  def audit_after_update
    input = {
      auditable: self,
      content: previous_changes,
      responsible_user: responsible_user.try(:email),
      action: :update
    }
    Audit.create(input)
  end

  def audit_after_destroy
    input = {
      auditable: self,
      content: attributes,
      responsible_user: responsible_user.try(:email),
      action: :destroy
    }
    Audit.create(input)
  end
end
