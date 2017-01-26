class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.string = :number
      t.string = :bill_uri
      t.text = :title
      t.string = :sponsor_uri
      t.string = :introduced_date
      t.string = :cosponsors
      t.string = :committees
      t.string = :primary_subject
      t.string = :latest_major_action_date
      t.string = :latest_major_action
      t.timestamps
    end
  end
end
