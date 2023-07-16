# frozen_string_literal: true

ActiveAdmin.register Studycard do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :hint, :first_studied_at, :last_studied_at, :state, :house, :reset_count, :visit_count, :flashcard_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:hint, :first_studied_at, :last_studied_at, :state, :house, :reset_count, :visit_count, :flashcard_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
