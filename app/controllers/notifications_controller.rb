class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    # Vérifier que toutes les données nécessaires sont présentes
    endpoint = params[:endpoint]
    auth_key = params.dig(:keys, :auth)
    p256dh_key = params.dig(:keys, :p256dh)
    
    # Support pour les tokens Capacitor (mobile)
    capacitor_token = params[:token]
    
    if capacitor_token.present?
      # Traitement spécial pour les tokens Capacitor
      endpoint = "capacitor://#{capacitor_token}"
      auth_key = "capacitor-auth-#{capacitor_token[0..10]}"
      p256dh_key = "capacitor-p256dh-#{capacitor_token[0..10]}"
    end
    
    if endpoint.blank? || auth_key.blank? || p256dh_key.blank?
      render json: {
        errors: [ "Données manquantes: endpoint, auth ou p256dh" ],
        message: "Notification non sauvegardée - données incomplètes"
      }, status: :unprocessable_entity
      return
    end

    notification = WebpushNotification.find_or_initialize_by(auth_key: auth_key)
    # Mettre à jour avec les nouvelles données
    notification.assign_attributes(
      endpoint: endpoint,
      auth_key: auth_key,
      p256dh_key: p256dh_key,
      capacitor_token: capacitor_token # Stocker le token Capacitor si présent
    )

    if notification.save
      render json: { notification: notification, message: "Notification saved" }, status: :created
    else
      render json: { errors: notification.errors.full_messages, message: "Notification not saved" }, status: :unprocessable_entity
    end
  end

  def send_notification
    message = params[:message] || "Notification de test depuis votre application !"
    notifications_sent = 0
    notifications_deleted = 0
    errors = []
    # Utiliser seulement les notifications valides
    valid_notifications = WebpushNotification.valid_subscriptions
    valid_notifications.each do |notification|
      # Vérification supplémentaire avant l'envoi
      unless notification.valid_for_sending?
        notification.destroy
        notifications_deleted += 1
        next
      end
      
      begin
        notification.send_notification(message)
        notifications_sent += 1
      rescue WebPush::InvalidSubscription => e
        # L'abonnement n'est plus valide, on le supprime
        Rails.logger.warn "Suppression de l'abonnement invalide #{notification.id}: #{e.message}"
        notification.destroy
        notifications_deleted += 1
      rescue WebPush::ExpiredSubscription => e
        # L'abonnement a expiré, on le supprime
        Rails.logger.warn "Suppression de l'abonnement expiré #{notification.id}: #{e.message}"
        notification.destroy
        notifications_deleted += 1
      rescue Net::HTTPNotFound => e
        # Endpoint FCM invalide (404), on le supprime
        Rails.logger.warn "Suppression de l'abonnement avec endpoint invalide #{notification.id}: #{e.message}"
        notification.destroy
        notifications_deleted += 1
      rescue => e
        # Autres erreurs, on les log mais on garde l'abonnement pour le moment
        error_msg = "Erreur pour #{notification.id}: #{e.message}"
        Rails.logger.error error_msg
        errors << error_msg
      end
    end
    
    total_before = WebpushNotification.count + notifications_deleted
    
    result_message = "#{notifications_sent} notifications envoyées"
    result_message += ", #{notifications_deleted} abonnements invalides supprimés" if notifications_deleted > 0
    result_message += " (sur #{total_before} total)"
    
    render json: { 
      message: result_message,
      notifications_sent: notifications_sent,
      notifications_deleted: notifications_deleted,
      errors: errors,
      success: errors.empty?
    }
  end

  def cleanup
    invalid_count = 0
    
    WebpushNotification.all.each do |notification|
      unless notification.valid_for_sending?
        notification.destroy
        invalid_count += 1
      end
    end
    
    render json: {
      message: "#{invalid_count} notifications invalides supprimées",
      remaining_count: WebpushNotification.count
    }
  end

  def stats
    total = WebpushNotification.count
    valid = WebpushNotification.valid_subscriptions.count
    invalid = total - valid
    
    render json: {
      total_notifications: total,
      valid_notifications: valid,
      invalid_notifications: invalid
    }
  end
end
