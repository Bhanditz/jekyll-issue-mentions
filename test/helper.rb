require 'rubygems'
require 'minitest/autorun'
require 'shoulda'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'jekyll-issue-mentions'

TEST_DIR     = File.expand_path("../", __FILE__)
FIXTURES_DIR = File.expand_path("fixtures", TEST_DIR)
DEST_DIR     = File.expand_path("destination", TEST_DIR)

module IssueMentionsTestHelpers
  def fixture_site
    Jekyll::Site.new(
      Jekyll::Utils.deep_merge_hashes(
        Jekyll::Configuration::DEFAULTS,
        {
          "source" => FIXTURES_DIR,
          "destination" => DEST_DIR,
          "collections" => {
            "docs"  => {}
          },
          "jekyll-issue-mentions" => {
            "base_url" => "https://github.com/usr1/repo1/issues"
          }
        }
      )
    )
  end

  def page_with_name(site, name)
    site.pages.find { |p| p.name == name }
  end

  def document(doc_filename)
    @site.collections["docs"].docs.find { |d| d.relative_path.match(doc_filename) }
  end
end
