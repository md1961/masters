class DbBackupsController < ApplicationController

  def index
    @files = %w[db/development.sqlite3 db/development.sqlite3.cp].sort_by { |f| File.mtime(f) }
  end
end
