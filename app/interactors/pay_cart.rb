class PayCart
  include Interactor::Organizer

  organize ResolveCartAndUser,
           AbortIfExpiredCart,
           MarkCartAsProcessing,
           InitializeTransaction,
           LogRequestingClientInTransaction,
           PopulateCartPaymentTransaction,
           CheckUserBalance,
           ApplyTransactionToUserBalance,
           CommitTransaction,
           ApplyAndDestroyCart
end
