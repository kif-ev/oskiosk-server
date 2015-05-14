class PayCart
  include Interactor::Organizer

  organize ResolveCartAndUser,
           InitializeTransaction,
           LogRequestingClientInTransaction,
           PopulateCartPaymentTransaction,
           ApplyTransactionToUserBalance,
           CommitTransaction,
           ApplyAndDestroyCart
end
