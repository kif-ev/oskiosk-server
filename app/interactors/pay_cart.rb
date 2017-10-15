class PayCart
  include Interactor::Organizer

  organize ResolveCartAndUser,
           MarkCartAsProcessing,
           InitializeTransaction,
           LogRequestingClientInTransaction,
           PopulateCartPaymentTransaction,
           CheckUserBalance,
           ApplyTransactionToUserBalance,
           CommitTransaction,
           ApplyAndDestroyCart,
           WarnIfProductQuantityBelowThreshold
end
