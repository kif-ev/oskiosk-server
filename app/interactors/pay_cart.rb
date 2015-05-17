class PayCart
  include Interactor::Organizer

  organize ResolveCartAndUser,
           InitializeTransaction,
           LogRequestingClientInTransaction,
           PopulateCartPaymentTransaction,
           CheckUserBalance,
           ApplyTransactionToUserBalance,
           CommitTransaction,
           ApplyAndDestroyCart
end
