class AddDepthToSpreeTaxons < ActiveRecord::Migration[4.2]
  def up
    if !Taxon.column_names.include?('depth')
      add_column :taxons, :depth, :integer

      say_with_time 'Update depth on all taxons' do
        Taxon.reset_column_information
        Taxon.all.each { |t| t.save }
      end
    end
  end

  def down
    remove_column :taxons, :depth
  end
end
