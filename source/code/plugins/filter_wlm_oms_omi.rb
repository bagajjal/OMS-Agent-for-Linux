
module Fluent

  class WlmOmsOmiFilter < Filter

    Plugin.register_filter('wlm_oms_omi', self)

    # This method is called before starting.
    def configure(conf)
      super
      @metadata_api_version = '2017-08-01'
    end

    def start
      super
    end

    # each record represents one line from the nagios log
    def filter(tag, time, record)
      begin
        url_metadata="http://169.254.169.254/metadata/instance?api-version=#{@metadata_api_version}"
        metadata_json = open(url_metadata,"Metadata"=>"true").read
        if not metadata_json.nil?
          return record
        end #if
      rescue =>e
        $log.error "Error processing VM perf data #{e}"
      end #begin
      return nil
    end #filter

  end #class

end #module
