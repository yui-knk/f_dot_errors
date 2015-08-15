require 'active_model'
require 'action_controller/railtie'
require 'action_view/railtie'

module FDotErrorsTestApp
  class Application < Rails::Application
    config.secret_token = 'happy hacking with ruby on rails'
    config.session_store :cookie_store, key: '_myapp_session'
    # config.active_support.deprecation = :log
    config.eager_load = false
    # config.action_dispatch.show_exceptions = false
    config.root = File.dirname(__FILE__)
  end
end
FDotErrorsTestApp::Application.initialize!

# routes
FDotErrorsTestApp::Application.routes.draw do
  resources :posts
end

# models
class Post < Struct.new(:author_name, :body, :updated_at)
  include ActiveModel::Model
end

# controllers
class ApplicationController < ActionController::Base
  self.append_view_path File.dirname(__FILE__)
end
ActionView::TestCase::TestController.append_view_path File.join(File.dirname(__FILE__), "views")
class PostsController < ApplicationController
  def show
    @post = Post.new
  end
end
