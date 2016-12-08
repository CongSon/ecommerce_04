# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def confirm_order
    user = User.first
    order = Order.first
    OrderMailer.confirm_order order, user
  end
end
