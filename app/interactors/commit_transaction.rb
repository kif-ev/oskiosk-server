class CommitTransaction
  include Interactor

  def call
    context.transaction.save!
  rescue
    context.fail!(message: 'generic.write_failed')
  end

  def rollback
    context.transaction.destroy!
  end
end
