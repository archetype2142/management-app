class AddIndexOnPrototypeToSpreeOptionTypePrototype < ActiveRecord::Migration[5.0]
  def change
    duplicates = OptionTypePrototype.group(:prototype_id, :option_type_id).having('sum(1) > 1').size

    duplicates.each do |f|
      prototype_id, option_type_id = f.first
      count = f.last - 1 # we want to leave one record
      otp = OptionTypePrototype.where(prototype_id: prototype_id, option_type_id: option_type_id).last(count)
      otp.map(&:destroy)
    end

    if index_exists? :option_type_prototypes, [:prototype_id, :option_type_id]
      remove_index :option_type_prototypes, [:prototype_id, :option_type_id]
      add_index :option_type_prototypes, [:prototype_id, :option_type_id], unique: true, name: 'option_type_prototypes_prototype_id_option_type_id'
    end

    add_index :option_type_prototypes, :prototype_id
  end
end
