class ChargesController < ApplicationController

  def downgrade
    current_user.update_attributes(role:"standard")
    flash[:notice] = "You have been cancelled, #{current_user.email}."
    redirect_to edit_user_registration_path(current_user)
  end

  def new
    @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "BigMoney Membership - #{current_user.last_name}",
    amount: Amount.default
    }
  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    @amount = 500

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "You have been upgraded, #{current_user.email}."

    current_user.update_attributes(role:"premium")
    redirect_to wikis_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end


  class Amount
    def self.default
      100
    end
  end

end
