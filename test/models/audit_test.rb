require "test_helper"

class AuditTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:auditable)
  end

  context 'validations' do
    should validate_presence_of(:action)
  end

  test 'should create audits for create, update, destroy' do
    # -- Arrange
    user_id = User.last.id
    action_results = %w[create update destroy]

    # -- Act
    election = Election.create(user_id: user_id)
    election.update(name: 'The Big One')
    election.destroy

    result = election.audits.pluck(:action)

    # -- Assert
    assert_equal(action_results, result)
  end

  test 'should change the election and create audit' do
    # -- Arrange
    audits_total = Audit.count

    election = elections(:one)

    election.responsible_user = election.user.email

    result_name = { name: 'The Big one' }

    # -- Act
    election.update(result_name)
    result = election.audits.last

    # -- Assert
    assert_predicate(result, :persisted?)

    assert_instance_of(::Audit, result)
    assert_instance_of(::Election, result.auditable)

    assert_equal('update', result.action)

    # -- Side effects
    assert_equal('The Big one', election.name)
    refute_equal(audits_total, Audit.count)
  end
end
