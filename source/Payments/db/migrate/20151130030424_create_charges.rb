class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.money :amount,            null: false
      t.string :unique_code,      null: false
      t.boolean :paid,            default: true
      t.boolean :refunded,        default: false
      t.integer :chargable_id,    null: false
      t.string :chargable_type,   null: false

      t.timestamps null: false
    end
    add_index :charges, :unique_code, unique: true
  end
end
