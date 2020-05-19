class MakeExistingCreditCardsDefault < ActiveRecord::Migration[4.2]
  def up
    # set the newest credit card for every user to be the default; SQL technique from
    # http://stackoverflow.com/questions/121387/fetch-the-row-which-has-the-max-value-for-a-column
    CreditCard.where.not(user_id: nil).joins("LEFT OUTER JOIN credit_cards cc2 ON cc2.user_id = credit_cards.user_id AND credit_cards.created_at < cc2.created_at").where("cc2.user_id IS NULL").update_all(default: true)
  end
  def down
    # do nothing
  end
end
