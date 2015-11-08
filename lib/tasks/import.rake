namespace :import do
  namespace :zkk do
    require 'oskiosk/importer/zkk'

    desc 'Import users in ZKK format'
    task :users, [:path] => [:environment] do |t,args|
      path = args[:path]
      raise(ArgumentError, "no path given")  unless path.present?
      Oskiosk::Importer::ZKK.import_users!(path)
    end

    desc 'Import products in ZKK format'
    task :products, [:path] => [:environment] do |t,args|
      path = args[:path]
      raise(ArgumentError, "no path given")  unless path.present?
      Oskiosk::Importer::ZKK.import_products!(path)
    end
  end

  namespace :boon do
    require 'oskiosk/importer/boon'

    desc 'Import users in Boon format'
    task :users, [:path] => [:environment] do |t,args|
      path = args[:path]
      raise(ArgumentError, "no path given")  unless path.present?
      Oskiosk::Importer::Boon.import_users!(path)
    end

    desc 'Import products in Boon format'
    task :products, [:path] => [:environment] do |t,args|
      path = args[:path]
      raise(ArgumentError, "no path given")  unless path.present?
      Oskiosk::Importer::Boon.import_products!(path)
    end
  end
end
