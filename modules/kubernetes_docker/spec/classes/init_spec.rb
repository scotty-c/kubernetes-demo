require 'spec_helper'
describe 'kubernetes_docker' do

  context 'with defaults for all parameters' do
    it { should contain_class('kubernetes_docker') }
  end
end
