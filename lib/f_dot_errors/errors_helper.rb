module FDotErrors
  module ErrorsHelper
    def errors(method)
      return unless object_has_errors?(method)

      FDotErrors.config.field_error_proc.call(object, method, @template)
    end

    private
      def object_has_errors?(key)
        object.respond_to?(:errors) && object.errors.respond_to?(:[]) && object.errors[key].present?
      end
  end
end
