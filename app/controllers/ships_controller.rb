class ShipsController < ApplicationController
  def change
    rename_column :addresses, :ships_id, :ship_id
  end
end
