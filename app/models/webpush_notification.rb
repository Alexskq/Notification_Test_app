class WebpushNotification < ApplicationRecord
  validates :endpoint, presence: true
  validates :auth_key, presence: true
  validates :p256dh_key, presence: true

  scope :valid_subscriptions, -> { where.not(endpoint: nil, auth_key: nil, p256dh_key: nil) }

  def valid_for_sending?
    endpoint.present? && auth_key.present? && p256dh_key.present?
  end

  def send_notification(message)
    WebPush.payload_send(
      message: message,
      endpoint: self.endpoint,
      p256dh: self.p256dh_key,
      auth: self.auth_key,
      vapid: {
        private_key: Rails.application.credentials.dig(:vapid_private_key),
        public_key: Rails.application.credentials.dig(:vapid_public_key)
      }
    )
  end
end
