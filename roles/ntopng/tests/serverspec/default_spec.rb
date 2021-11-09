require "spec_helper"
require "serverspec"

package = ""
service = "ntopng"
config_dir = "/etc/ntopng"
config_mode = 644
user = "ntopng"
group = "ntopng"
default_user = "root"
default_group = "wheel"
ports = [3001]
extra_groups = %w[bin]
extra_packages = []
log_dir = ""
db_dir = ""

case os[:family]
when "openbsd"
  user = "_ntopng"
  group = "_ntopng"
  package = "ntopng"
  db_dir = "/var/db/ntopng"
  log_dir = db_dir
when "freebsd"
  config_dir = "/usr/local/etc/ntopng"
  log_dir = "/var/db/ntopng"
  db_dir = log_dir
when "ubuntu"
  default_group = "root"
  log_dir = "/var/log/ntopng"
  db_dir = "/var/lib/ntopng"
  config_mode = 664
when "redhat"
  default_group = "root"
  log_dir = "/var/log/ntopng"
  db_dir = "/var/lib/ntopng"
  config_mode = 644
end

log_dir_mode = 750
log_mode = 600
log_dir_owner = user
log_dir_group = group
log_file = ""
case os[:family]
when "ubuntu", "redhat"
  log_file = "/var/log/ntop-systemd.log"
else
  log_file = "#{log_dir}/ntopng.log"
end
config = "#{config_dir}/ntopng.conf"

describe package(package) do
  it { should be_installed }
end

extra_packages.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe user(user) do
  it { should belong_to_group group }
  extra_groups.each do |g|
    it { should belong_to_group g }
  end
end

describe file(config_dir) do
  it { should exist }
  it { should be_directory }
  case os[:family]
  when "ubuntu"
    it { should be_mode 775 }
  else
    it { should be_mode 755 }
  end
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_mode config_mode }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(/Managed by ansible/) }
  its(:content) { should match(/--http-port=\d+\.\d+\.\d+\.\d+:3001/) }
  its(:content) { should match(/--disable-login=1/) }
end

describe file(db_dir) do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(log_dir) do
  it { should be_directory }
  it { should be_mode log_dir_mode }
  it { should be_owned_by log_dir_owner }
  it { should be_grouped_into log_dir_group }
end

case os[:family]
when "openbsd"
  describe file("/etc/rc.conf.local") do
    it { should be_file }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    it { should be_mode 644 }
  end
when "redhat"
  describe file("/etc/sysconfig/#{service}") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    its(:content) { should match(/Managed by ansible/) }
  end
when "ubuntu"
  describe file("/etc/default/#{service}") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    its(:content) { should match(/Managed by ansible/) }
  end
when "freebsd"
  describe file("/etc/rc.conf.d") do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
  end

  describe file("/etc/rc.conf.d/#{service}") do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    its(:content) { should match(/Managed by ansible/) }
    its(:content) { should match(/ntopng_flags='#{config}'/) }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it do
      if os[:family] == "openbsd"
        pending "due to bug in serverspec, port does not work on OpenBSD"
      end
      should be_listening
    end
  end
end

describe file(log_file) do
  it { should be_file }
  case os[:family]
  when "ubuntu", "redhat"
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    it { should be_mode 644 }
  else
    it { should be_owned_by user }
    it { should be_grouped_into group }
    it { should be_mode log_mode }
  end
end
