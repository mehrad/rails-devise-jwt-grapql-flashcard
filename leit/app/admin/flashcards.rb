# frozen_string_literal: true

ActiveAdmin.register Flashcard do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :answer, :question, :image_url, :box_id, :tag_list
  #
  # or
  #
  # permit_params do
  #   permitted = [:answer, :question, :image_url, :box_id, :tag_list]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
