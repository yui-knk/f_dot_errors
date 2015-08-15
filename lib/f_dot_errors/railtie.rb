require 'rails'
require 'action_view'

module FDotErrors
  class Railtie < ::Rails::Railtie
    initializer "f_dot_errors" do
      ActiveSupport.on_load(:action_view) do
        require 'f_dot_errors/errors_helper'
        ActionView::Helpers::FormBuilder.send :include, FDotErrors::ErrorsHelper
      end
    end
  end
end
