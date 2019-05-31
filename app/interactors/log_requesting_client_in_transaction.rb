class LogRequestingClientInTransaction
  include Interactor

  def call
    # TODO: Adapt to new auth framework
    # context.transaction.application = context.requesting_application
    # context.transaction.application_name = context.requesting_application.name
  end
end
