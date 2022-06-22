module MerriamWebsterPlus
  class EntryAudioMerger
    attr_reader :dst_entries, :src_entries

    def initialize(dst_entries:, src_entries:)
      @dst_entries = dst_entries
      @src_entries = src_entries
    end

    def merged_entries
      heteronym? ? entries_with_multi_audio : entries_with_single_audio
    end

    private

    def heteronym?
      audios.size > 1
    end

    def entries_with_multi_audio
      return remove_ids(dst_entries) if dst_entries == src_entries

      dst_entries.each do |dst_entry|
        target_uuid = dst_entry[:target_uuid]
        dst_entry[:audio] = src_entries_audio_index[target_uuid]
      end
      remove_ids(dst_entries)
    end

    def src_entries_audio_index
      indexed_audio = {}
      src_entries.each do |src_entry|
        indexed_audio[src_entry[:uuid]] ||= src_entry[:audio]
      end
      indexed_audio
    end

    def entries_with_single_audio
      dst_entries.map { |dst_entry| dst_entry[:audio] = src_audio }
      remove_ids(dst_entries)
    end

    def src_audio
      audios.first
    end

    def audios
      src_entries.map { |entry| entry.slice(:audio)[:audio] }.compact.uniq
    end

    def remove_ids(entries)
      entries.map { |entry| entry.except(:uuid, :target_uuid) }
    end
  end
end
