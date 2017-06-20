require "spec_helper"
require "serverspec"

localtime_zone = "Japan"

case os[:family]
when "freebsd"
  localtime_zone = "Asia/Tokyo"
end

describe file("/etc/localtime") do
  it { should exist }
  it { should be_symlink }
  it { should be_linked_to "/usr/share/zoneinfo/#{localtime_zone}" }
end

describe command("date +%z") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^\+0900$/) }
  its(:stderr) { should eq "" }
end
