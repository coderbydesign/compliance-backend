# frozen_string_literal: true

module V2
  # JSON serialization for Security Guides
  class SecurityGuideSerializer < V2::ApplicationSerializer
    attributes :ref_id, :title, :version, :description, :os_major_version

    derived_attribute :os_major_version, :ref_id
  end
end
