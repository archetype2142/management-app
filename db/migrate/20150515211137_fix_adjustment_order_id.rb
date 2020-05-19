class FixAdjustmentOrderId < ActiveRecord::Migration[4.2]
  def change
    say 'Populate order_id from adjustable_id where appropriate'
    execute(<<-SQL.squish)
      UPDATE
        adjustments
      SET
        order_id = adjustable_id
      WHERE
        adjustable_type = 'Order'
      ;
    SQL

    # Submitter of change does not care about MySQL, as it is not officially supported.
    # Still spree officials decided to provide a working code path for MySQL users, hence
    # submitter made a AR code path he could validate on PostgreSQL.
    #
    # Whoever runs a big enough MySQL installation where the AR solution hurts:
    # Will have to write a better MySQL specific equivalent.
    if Order.connection.adapter_name.eql?('MySQL')
      Adjustment.where(adjustable_type: 'LineItem').find_each do |adjustment|
        adjustment.update_columns(order_id: LineItem.find(adjustment.adjustable_id).order_id)
      end
    else
      execute(<<-SQL.squish)
        UPDATE
          adjustments
        SET
          order_id =
            (SELECT order_id FROM line_items WHERE line_items.id = adjustments.adjustable_id)
        WHERE
          adjustable_type = 'LineItem'
      SQL
    end

    say 'Fix schema for adjustments order_id column'
    change_table :adjustments do |t|
      t.change :order_id, :integer, null: false
    end

    # Improved schema for postgresql, uncomment if you like it:
    #
    # # Negated Logical implication.
    # #
    # # When adjustable_type is 'Order' (p) the adjustable_id must be order_id (q).
    # #
    # # When adjustable_type is NOT 'Order' the adjustable id allowed to be any value (including of order_id in
    # # case foreign keys match). XOR does not work here.
    # #
    # # Postgresql does not have an operator for logical implication. So we need to build the following truth table
    # # via AND with OR:
    # #
    # #  p q | CHECK = !(p -> q)
    # #  -----------
    # #  t t | t
    # #  t f | f
    # #  f t | t
    # #  f f | t
    # #
    # # According to de-morgans law the logical implication q -> p is equivalent to !p || q
    # #
    # execute(<<-SQL.squish)
    #   ALTER TABLE ONLY adjustments
    #    ADD CONSTRAINT fk_adjustments FOREIGN KEY (order_id)
    #      REFERENCES orders(id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    #    ADD CONSTRAINT check_adjustments_order_id CHECK
    #      (adjustable_type <> 'Order' OR order_id = adjustable_id);
    # SQL
  end
end
