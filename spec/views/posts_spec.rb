require 'spec_helper'

describe "posts/show", type: :view do
  before do
    @post = Post.new
    @post.errors[:author_name] << "can't be empty"
    @post.errors[:body] << "foo"

    @post.author_name = ""
    @post.body        = "Back to the hill and over it again!"
    @post.updated_at  = Date.new(2004, 6, 15)
  end

  it "render errors with default proc" do
    assign(:post, @post)
    render
    expect(rendered).to euqal_dom <<-HTML.chomp
<form class="new_post" id="new_post" action="/posts" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
  <div class="field_with_errors">Author name can't be empty</div>
  <div class="field_with_errors">Body foo</div>
  
</form>
HTML
  end

  context "with custom field_error_proc" do
    before do
      @before_proc = FDotErrors.config.field_error_proc
      FDotErrors.configure do |c|
        c.field_error_proc = Proc.new { |instance, method, template|

        lis = instance.errors.full_messages_for(method).map do |msg|
          template.content_tag(:li, msg, {class: "field_with_errors_list_item"}, false)
        end.join("\n").html_safe
        template.content_tag(:ul, lis, class: "field_with_errors_list")
      } 
      end
    end

    after do
      FDotErrors.configure {|c| c.field_error_proc = @before_proc}
    end

    it "render errors with custom proc" do
      assign(:post, @post)
      render
      expect(rendered).to euqal_dom <<-HTML.chomp
<form class="new_post" id="new_post" action="/posts" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
  <ul class="field_with_errors_list"><li class="field_with_errors_list_item">Author name can't be empty</li></ul>
  <ul class="field_with_errors_list"><li class="field_with_errors_list_item">Body foo</li></ul>
  
</form>
HTML
    end
  end
end
