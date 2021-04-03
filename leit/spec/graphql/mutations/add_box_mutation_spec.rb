# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::AddBoxMutation do
  it 'adds in box' do
    user = create(:user)

    variables = {
      'title' => 'title?',
      'desc' => 'desc'
    }

    context = {
      current_user: user
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys.dig(:data, :addBox)

    expect(result.dig(:box, :title)).to eq(variables['title'])
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it 'raises authentication error without context' do
    variables = {
      'title' => 'title?',
      'desc' => 'desc'
    }
    box = create(:box, **variables.symbolize_keys)

    context = {
      current_user: nil
    }

    result = gql_query(query: mutation, variables: variables, context: context)
    result = result.to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq('You need to authenticate to perform this action')
    expect(result[:addBox]).to be_blank
  end

  def mutation
    <<~GQL
      mutation AddBox($title: String!, $desc: String!) {
      	addBox(input: { title: $title, desc: $desc }) {
      	box {
      		id
      		title
      		desc
      		user {
      			id
      			email
      		}
      	}
      	success
      	errors
      	}
      }
    GQL
  end
end
