# frozen_string_literal: true

class User < ApplicationRecord
  include Auditable

  audit_after_create
  audit_after_update
  audit_after_destroy

  has_many :elections
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
