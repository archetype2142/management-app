class AddUniqueIndexOnNumberToSpreeReturnAuthorizations < ActiveRecord::Migration[5.0]
  def change
    unless index_exists?(:return_authorizations, :number, unique: true)
      numbers = ReturnAuthorization.group(:number).having('sum(1) > 1').pluck(:number)
      authorizations = ReturnAuthorization.where(number: numbers)

      authorizations.find_each do |authorization|
        authorization.number = authorization.class.number_generator.method(:generate_permalink).call(authorization.class)
        authorization.save
      end

      remove_index :return_authorizations, :number if index_exists?(:return_authorizations, :number)
      add_index :return_authorizations, :number, unique: true
    end
  end
end
