# This Module extends the as_json method in your model to easily customize the JSON output
#
# Example:
# include JsonSerializable
# json_serializable [:name, :description], :private => lambda {|model| model.secret}
# this will produce the following Hash
# {:name => model.name, :description => model.description, :private => model.secret}
#
# This module works best when you want to whitelist your attributes for JSON and want to
# use different names/values than your attributes name in the models

require "json_serializable/version"

module JsonSerializable

  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods

    def as_json(options = {})
      super(custom_options(self.class.json_field_names, options)).merge hash_from_mappings(self.class.json_mappings)
    end

    private
    def custom_options(fields, options)
      options ||= {}
      if fields.size > 0
        options[:only] ||= []
        options[:only] |= fields
      end
      options
    end

    def hash_from_mappings(mappings)
      custom_hash = {}
      mappings.each_pair do |key, value|
        if value.is_a?(Symbol)
           custom_hash[value] = self.send(key)
        else
           custom_hash[key] = value[self]
        end
      end
      custom_hash
    end
  end

  module ClassMethods

    def json_serializable field_names, mappings = {}
      @@json_field_names = field_names
      @@json_mappings = mappings
    end

    def json_field_names
      @@json_field_names ||= []
    end

    def json_mappings
      @@json_mappings ||= {}
    end

  end

end
