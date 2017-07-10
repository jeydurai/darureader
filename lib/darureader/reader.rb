require 'roo'
require 'daru'

# Main class of Excel xlsx file reader
class ExcelReader
    attr_reader :array_of_hashes, :dataframe

    def initialize(filename, sheetname, skiprows, readrows, aoh, hoa) #:notnew:
        @filename = filename
        @aoh = aoh
        @hoa = hoa
        @array_of_hashes= [] # Array of hashes
        @hash_of_arrays= {} # Hash of arrays
        set_file_credentials(sheetname, skiprows, readrows)
    end

    # Sets all Excel file credentials
    def set_file_credentials(sht_name, skip, read)
        @sht = Roo::Excelx.new(@filename).sheet(sht_name)
        @lrow = @sht.last_row
        @lcol = @sht.last_column
        @skiprows = skip
        @headers = @sht.row(@skiprows+1)
        create_hash_of_arrays_container
        @readrows = read ? read+@skiprows : @lrow
    end

    # Create a hash of arrays container
    def create_hash_of_arrays_container
        @headers.each { |h| @hash_of_arrays[h] = [] }
    end

    # Creates and returns Daru::DataFrame object from hash of arrays
    def dataframe
        return nil unless @hoa
        Daru::DataFrame.new(@hash_of_arrays)
    end

    # Executes the reading of Excel sheet
    def read
        @lrow.times do |i|
            row_idx = i + 1
            next if row_idx <= @skiprows+1
            row_data = @sht.row(row_idx)
            set_hash_of_arrays(row_data) if @hoa
            if @aoh
                row_dict = {}
                @headers.each_with_index do |h, i|
                    temp_dict = { h => row_data[i] }
                    row_dict.merge!(temp_dict)
                end
                @array_of_hashes<< row_dict
            end
            break if row_idx > @readrows
        end
    end

    # Sets the read data as Hash of arrays so that it can be 
    # converted as Daru::DataFrame object
    def set_hash_of_arrays row
        @headers.each_with_index do |h, i|
            @hash_of_arrays[h] << row[i]
        end
    end

    private :set_file_credentials, :set_hash_of_arrays, 
        :create_hash_of_arrays_container
    public :read, :dataframe
end
