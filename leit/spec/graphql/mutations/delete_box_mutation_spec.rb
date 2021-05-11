# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::DeleteBoxMutation do
  it 'deletes a box' do
    user = create(:user_with_boxes_flashcards_studycards)

    variables = {
      'id' => user.boxes.first.id
    }

    context = {
      current_user: user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys.dig(:data, :deleteBox)

    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it 'raises authentication error without context' do
    variables = {
      'id' => '1'
    }

    context = {
      current_user: nil
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq('You need to authenticate to perform this action')
    expect(result[:deleteBox]).to be_blank
  end

  it 'raiases authentication if box does not belongs to me' do
    user = create(:user_with_boxes_flashcards_studycards)
    other_user = create(:user)
    variables = {
      'id' => user.boxes.first.id
    }

    context = {
      current_user: other_user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq('You need to authenticate to perform this action')
    expect(result[:deleteBox]).to be_blank
  end

  def mutation
    <<~GQL
      mutation DeleteBox($id: ID!) {
      	deleteBox(input: { id: $id }) {
      	success
      	errors
      	}
      }
    GQL
  end
end
