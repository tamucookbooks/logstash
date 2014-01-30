actions :create, :remove

default_action :create

attribute :plugin, :kind_of => String, :required => true
attribute :type, :kind_of => String
attribute :tags, :kind_of => Array
attribute :debug, :kind_of => [TrueClass,FalseClass], :default => false
attribute :options, :kind_of => Hash
