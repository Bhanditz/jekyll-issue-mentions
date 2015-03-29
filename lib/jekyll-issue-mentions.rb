require 'jekyll'
require 'html/pipeline'
require 'issue_mention_filter'

module Jekyll
  class IssueMentions < Jekyll::Generator
    safe true
    attr_reader :base_url, :issueid_pattern

    def initialize(config = Hash.new)
      validate_config!(config)
    end

    def generate(site)
      site.pages.each { |page| mentionify page if html_page?(page) }
      site.posts.each { |post| mentionify post }
      site.docs_to_write.each { |doc| mentionify doc }
    end

    def mentionify(page)
      return unless page.content.include?('#')
      filter = HTML::Pipeline::IssueMentionFilter.new(page.content, base_url: base_url, issueid_pattern: issueid_pattern)
      page.content = filter.call.to_s.
        gsub("&gt;", ">").
        gsub("&lt;", "<").
        gsub("%7B", "{").
        gsub("%20", " ").
        gsub("%7D", "}")
    end

    def html_page?(page)
      page.html? || page.url.end_with?('/')
    end

  private
    def validate_config!(configs)
      configs = configs['jekyll-issue-mentions']
      base_url = issueid_pattern = nil
      case configs
      when String
        base_url = configs
      when Hash
        base_url, issueid_pattern = configs['base_url'], configs['issueid_pattern']
        issueid_pattern = /#{issueid_pattern}/ if issueid_pattern.is_a?(String)
      end
      error_prefix = "jekyll-issue-mentions"
      raise ArgumentError.new("#{error_prefix}.base_url is missing/empty") if (base_url.nil? || base_url.empty?)
      raise ArgumentError.new("#{error_prefix}.issueid_pattern is invalid") if (!issueid_pattern.nil? && !issueid_pattern.is_a?(Regexp))

      @base_url, @issueid_pattern = base_url, issueid_pattern
    end
  end
end
