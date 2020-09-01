# frozen_string_literal: true

module MongoDBLibCookbook
  module MongoDBLibHelpers
    module Repo
      def coerce_repo_version(version)
        version.to_f.to_s
      end
    end
  end
end
