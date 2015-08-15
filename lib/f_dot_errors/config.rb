require 'active_support/configurable'

module FDotErrors
  def self.configure(&block)
    yield @config ||= FDotErrors::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable

    # see ActionView::Base.field_error_proc
    config_accessor :field_error_proc do
      Proc.new { |instance, method, template|
        msgs = instance.errors.full_messages_for(method).join("\n")
        "<div class=\"field_with_errors\">#{msgs}</div>".html_safe
      }
    end
  end

  configure {}
end
