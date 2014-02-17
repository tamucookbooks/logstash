actions :create, :remove

default_action :create

attribute :plugin, kind_of: String, required: true
attribute :type, kind_of: String
attribute :options, kind_of: Hash
