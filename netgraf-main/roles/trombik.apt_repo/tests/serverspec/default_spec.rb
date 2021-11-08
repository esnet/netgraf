require "spec_helper"
require "serverspec"

packages = %w[gnupg ca-certificates]
codename = Specinfra.backend.run_command("lsb_release -c")
                    .stdout.strip.split(" ")[1]
# apt-key output:
#
# before 18.04
# pub   2048R/D88E42B4 2013-09-16
# uid                  Elasticsearch (Elasticsearch Signing Key) <dev_ops@elasticsearch.org>
# sub   2048R/60D31954 2013-09-16
elasticsearch_key_id = "2048R/D88E42B4"

# after 18.04
# pub   rsa2048 2013-09-16 [SC]
#      4609 5ACC 8548 582C 1A26  99A9 D27D 666C D88E 42B4
# uid           [ unknown] Elasticsearch (Elasticsearch Signing Key) <dev_ops@elasticsearch.org>
# sub   rsa2048 2013-09-16 [E]
elasticsearch_key = "4609 5ACC 8548 582C 1A26  99A9 D27D 666C D88E 42B4"

packages.each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe file("/usr/bin/gpg") do
  it { should be_file }
end

describe command("apt-key list") do
  case os[:family]
  when "ubuntu"
    if os[:release].to_f >= 18.04
      its(:stdout) { should match(/#{elasticsearch_key}/) }
    else
      its(:stdout) { should match(/^pub\s+#{elasticsearch_key_id}\s+.*$/) }
    end
  when "devuan"
    its(:stdout) { should match(/#{elasticsearch_key}/) }
  end
end

describe file("/etc/apt/sources.list.d/artifacts_elastic_co_packages_7_x_apt.list") do
  its(:content) { should match(/^deb #{ Regexp.escape("https://artifacts.elastic.co/packages/7.x/apt") } stable main$/) }
end

# ppa:ubuntuhandbook1/audacity
case os[:family]
when "ubuntu"
  describe file("/etc/apt/sources.list.d/ppa_ubuntuhandbook1_audacity_#{codename}.list") do
    its(:content) { should match(/^deb #{ Regexp.escape("http://ppa.launchpad.net/ubuntuhandbook1/audacity/ubuntu") } #{codename} main$/) }
  end
when "devuan"
  describe file("/etc/apt/sources.list.d/repos_influxdata_com_debian.list") do
    its(:content) { should match(/^deb #{ Regexp.escape("https://repos.influxdata.com/debian") } \S+ stable$/) }
  end
end
