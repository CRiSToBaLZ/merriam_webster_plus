require "merriam_webster_plus/dictionary_plus"

module MerriamWebsterPlus
  class Populator
    attr_reader :lookupper, :src_dir, :dst_dir

    def initialize(lookupper:, src_dir:, dst_dir:)
      @lookupper 			= lookupper
      @src_dir 			= src_dir
      @dst_dir 			= dst_dir
    end

    def populate
      csv_out = CSV.open(dst_dir, "wb", write_headers: true, headers: src_headers)

      CSV.foreach(src_dir, headers: true, header_converters: :symbol) do |src_row|
        entry = lookupper.new(word: src_row[0]).primary_entry
        entry ? (csv_out << entry.values) : (csv_out << src_row)
      rescue StandardError
        csv_out << src_row
      end
      csv_out.close
    end

    private

    def src_headers
      CSV.foreach(src_dir).first
    end
  end
end
