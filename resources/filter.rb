actions :create, :remove

default_action :create

attribute :plugin, :kind_of => String, :required => true
attribute :add_field, :kind_of => String
attribute :add_tag, :kind_of => String
attribute :remove_field, :kind_of => String
attribute :remove_tag, :kind_of => String
attribute :options, :kind_of => Hash
