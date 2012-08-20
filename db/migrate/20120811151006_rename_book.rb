class RenameBook < ActiveRecord::Migration
   def self.up
        rename_table :books, :origins
    end 
    def self.down
        rename_table :books, :origins
    end
end
