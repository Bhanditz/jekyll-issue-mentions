require 'jekyll'
require 'html/pipeline'
require 'issue_mention_filter'

module Jekyll
  class IssueMentions < Jekyll::Generator
    safe true
    attr_reader :base_url, :issueid_pattern

    def initialize(config = Hash.new)
      validate_config!(config)
      @filter = HTML::Pipeline::IssueMentionFilter.new(nil, base_url: base_url, issueid_pattern: issueid_pattern)
    end

    def generate(site)
      site.pages.each { |page| mentionify page if html_page?(page) }
      site.posts.each { |post| mentionify post }
      site.docs_to_write.each { |doc| mentionify doc }
    end

    def mentionify(page)
      return unless page.content.include?('#')
      page.content = @filter.mention_link_filter(page.content, @filter.base_url, @filter.issueid_pattern)
    end

    def html_page?(page)
      page.html? || page.url.end_with?('/')
    end

  private
    def validate_config!(configs)
      configs = configs['jekyll-issue-mentions']
      @plugin_options ||= begin
        case configs
        when nil, NilClass
          raise ArgumentError.new("Your jekyll-issue-mentions config has to configured.")
        when String
          if configs.strip.empty?
            raise ArgumentError.new("Your jekyll-issue-mentions config is configured with empty string")
          else
            @base_url = configs
          end
        when Hash
          @base_url, @issueid_pattern = configs['base_url'], configs['issueid_pattern']
          if @base_url.nil? || @base_url.empty?
            raise ArgumentError.new("Your jekyll-issue-mentions is missing base_url configuration.")
          end
        else
          raise ArgumentError.new("Your jekyll-issue-mentions config has to either be a string or a hash! It's a #{configs.class} right now.")
        end
      end
    end
  end
end
