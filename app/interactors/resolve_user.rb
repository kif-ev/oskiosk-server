class ResolveUser
  include Interactor

  def call
    context.user = User.find_by_id!(context.user_id)
  rescue ActiveRecord::RecordNotFound
    context.fail!(message: 'generic.not_found')
  end
end
