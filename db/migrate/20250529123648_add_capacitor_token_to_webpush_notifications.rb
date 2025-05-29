class AddCapacitorTokenToWebpushNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :webpush_notifications, :capacitor_token, :string
  end
end
