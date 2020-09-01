# frozen_string_literal: true

def supported_platforms
  {
    'centos' => ['6.7', '7.2.1511'],
    'debian' => ['7.10', '8.4'],
    'ubuntu' => ['12.04', '14.04']
  }.each_pair do |platform, versions|
    versions.each do |version|
      yield platform, version
    end
  end
end
