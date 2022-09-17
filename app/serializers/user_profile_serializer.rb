class UserProfileSerializer < ActiveModel::Serializer
    attribute :profile
    attribute :platform
    attribute :message

    def message
      instance_options[:message]
    end
  end
  