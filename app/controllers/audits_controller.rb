class AuditsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @elections = Audit.all.where(auditable_type: "Election").order(created_at: :desc)
    @voters = Audit.all.where(auditable_type: "Voter").order(created_at: :desc)
    @answers = Audit.all.where(auditable_type: "Answer").order(created_at: :desc)
    @questions = Audit.all.where(auditable_type: "Question").order(created_at: :desc)
  end
end
