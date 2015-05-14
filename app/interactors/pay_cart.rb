class PayCart
  include Interactor::Organizer

  organize ResolveCartAndUser,
           InitializeTransaction,
           PopulateCartPaymentTransaction,
           ApplyTransactionToUserBalance,
           CommitTransaction,
           ApplyAndDestroyCart
end
