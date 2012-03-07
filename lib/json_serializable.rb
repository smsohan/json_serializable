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
      options ||= {}
      custom_options = self.class.json_field_names.size > 0 ? options.merge(only: self.class.json_field_names) : options
      custom_hash = super(custom_options)

      self.class.json_mappings.each_pair do |key, value|
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
