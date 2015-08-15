require 'rails/dom/testing/assertions/dom_assertions'

RSpec::Matchers.define :euqal_dom do |expected|
  include Rails::Dom::Testing::Assertions::DomAssertions

  match do |actual|
    @actual = actual
    @expected = expected

    expected_dom, actual_dom = fragment(expected), fragment(actual)
    compare_doms(expected_dom, actual_dom)
  end

  failure_message_when_negated do
    "Expected: #{@expected}\nActual: #{@actual}"
  end

  failure_message do
    "Expected: #{@expected}\nActual: #{@actual}"
  end
end
