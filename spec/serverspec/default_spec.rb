require 'spec_helper'
require 'serverspec'

describe file('/etc/localtime') do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to '/usr/share/zoneinfo/Asia/Tokyo' }
end

describe command('date +%z') do
  its(:stdout) { should match /^\+0900$/ }
  its(:stderr) { should match /^$/ }
end
