require 'spec_helper'

describe FDotErrors::Configuration do
  describe 'field_error_proc' do
    context 'by default' do
      it { expect(FDotErrors.config.field_error_proc).to be_a(Proc) }
    end

    context 'configured via config block' do
      before do
        @before_proc = FDotErrors.config.field_error_proc
        FDotErrors.configure {|c| c.field_error_proc = 10}
      end

      after do
        FDotErrors.configure {|c| c.field_error_proc = @before_proc}
      end

      it { expect(FDotErrors.config.field_error_proc).to eq 10 }
    end
  end
end
