namespace :admin do
  desc 'Create a new admin'
  task :create, [:email, :password] => [:environment] do |t,args|
    email = args[:email]
    raise(ArgumentError, 'no email given') unless email.present?
    password = args[:password]
    raise(ArgumentError, 'no password given') unless password.present?
    Admin.create(
        email: email,
        password: password
    )
  end
end
