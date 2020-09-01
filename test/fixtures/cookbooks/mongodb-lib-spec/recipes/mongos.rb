# frozen_string_literal: true

mongos 'mongos' do
  config(
    'net' => {
      'bindIp' => '0.0.0.0'
    }
  )
end
