# frozen_string_literal: true

ActiveAdmin.register Box do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :desc, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :desc, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    id_column
    column :title
  end
end
