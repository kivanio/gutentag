require 'active_support/core_ext/module/attribute_accessors'

module Gutentag

  mattr_accessor :tag_name_delimiter
  @@tag_name_delimiter = ','

  def self.configure
    yield self
  end
  
  def self.normaliser
    @normaliser ||= Gutentag::TagName
  end

  def self.normaliser=(normaliser)
    @normaliser = normaliser
  end
end

require 'gutentag/active_record'
require 'gutentag/engine'
require 'gutentag/persistence'
require 'gutentag/tag_name'
