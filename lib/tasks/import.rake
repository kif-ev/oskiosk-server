namespace :import do
  namespace :regensburg do
    require 'oskiosk/importer/regensburg'

    desc 'Import Teilnehmer in Regensburg Format'
    task :teilnehmer, [:path] => [:environment] do |_, args|
      path = args[:path]
      raise(ArgumentError, 'no path given') unless path.present?
      Oskiosk::Importer::Regensburg.import_users!(path)
    end
  end
end
