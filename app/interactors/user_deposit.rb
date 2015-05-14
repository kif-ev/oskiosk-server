class UserDeposit
  include Interactor::Organizer

  organize ResolveUser,
           InitializeTransaction,
           LogRequestingClientInTransaction,
           PopulateUserDepositTransaction,
           ApplyTransactionToUserBalance,
           CommitTransaction
end
