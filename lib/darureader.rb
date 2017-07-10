require "darureader/version"
require 'darureader/reader'
require 'darureader/validator'


#= Main module contains all entry points and classes
module Darureader

    # Sub class of Reader class containing XLSX files reading functionality
    class Excelx < ExcelReader
        
        def initialize(filename: nil, sheetname: 0, skiprows: 0, readrows: nil,
                       arr_of_hash: true, hash_of_arr: true) #:notnew:
            validate(filename)
            super(filename, sheetname, skiprows, readrows, arr_of_hash,
                  hash_of_arr)
        end

        def validate filename
            unless filename
                puts "[Error]: 'filename' parameter expected."
                exit
            end
            unless Validator::FileValidator.new(filename).validate
                puts "[Error]: Either #{filename} doesn't exist or isn't a file"
                exit
            end
        end

        private :validate
    end

end
