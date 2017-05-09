class DbBackupsController < ApplicationController

  DB_FILE     = 'db/development.sqlite3'
  BACKUP_FILE = 'db/development.sqlite3.cp'

  def index
    set_files
  end

  def create
    FileUtils.cp(DB_FILE, BACKUP_FILE) if File.mtime(DB_FILE) > File.mtime(BACKUP_FILE)
    set_files
    render :index
  end

  private

    def set_files
      @files = [DB_FILE, BACKUP_FILE].sort_by { |f| File.mtime(f) }
    end
end
