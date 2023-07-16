# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel 'Recent Boxes' do
          ul do
            Box.take(5).map do |box|
              li link_to(box.title, admin_box_path(box))
            end
          end
        end
      end

      column do
        panel 'Recent Flashcards' do
          ul do
            Flashcard.take(5).map do |flashcard|
              li link_to(flashcard.question, admin_flashcard_path(flashcard))
            end
          end
        end
      end

      column do
        panel 'Recent Studycards' do
          ul do
            Studycard.take(5).map do |studycard|
              li link_to(studycard.question, admin_studycard_path(studycard))
            end
          end
        end
      end
    end
  end
end
