class NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy, :show]

  # GET /api/notifications
  def index
    notifications = Notification.all.order(created_at: :desc)
    notifications.update_all(read: true)
    render json: notifications, status: :ok
  end

  def show
    render json: @notification, status: :ok
  end

  # DELETE /notifications/:id
  def destroy
    @notification.destroy
    render json: { message: 'Notification successfully deleted' }, status: :no_content
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end











