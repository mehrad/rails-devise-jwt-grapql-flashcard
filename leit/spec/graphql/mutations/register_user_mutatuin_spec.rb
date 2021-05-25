# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::RegisterUserMutation do
  it 'registers the user' do
    variables = {
      'email' => 'mahrad@gmail.com',
      'password' => 'testing123'
    }

    result = gql_query(query: mutation, variables: variables)
    result = result.to_h.deep_symbolize_keys.dig(:data, :registerUser)

    expect(result.dig(:user, :id)).to eq(User.last.id.to_s)
    expect(result.dig(:user, :authenticationToken))
      .to eq(User.last.authentication_token)
    expect(result[:success]).to eq(true)
    expect(result[:errors]).to be_blank
  end

  it 'raises error on missing email' do
    variables = {
      'email' => '',
      'password' => 'testing123'
    }

    result = gql_query(query: mutation, variables: variables)
             .to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq("Invalid Attributes for User: Email can't be blank")
    expect(result.dig(:data, :registerUser)).to be_blank
  end

  it 'raises error on missing passowrd' do
    variables = {
      'email' => 'mahrad@gmail.com',
      'password' => ''
    }

    result = gql_query(query: mutation, variables: variables)
             .to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq("Invalid Attributes for User: Password can't be blank")
    expect(result.dig(:data, :registerUser)).to be_blank
  end

  it 'raises error if users exists' do
    variables = {
      'email' => 'mahrad@gmail.com',
      'password' => 'testing123'
    }

    user = create(:user, **variables.symbolize_keys)

    result = gql_query(query: mutation, variables: variables)
             .to_h.deep_symbolize_keys

    expect(result.dig(:errors, 0, :message)).to eq("Invalid Attributes for User: Email has already been taken")
    expect(result.dig(:data, :registerUser)).to be_blank
  end

  def mutation
    <<~GQL
      mutation registerUser($email: String!, $password: String!) {
        registerUser(input: {email: $email, password: $password }) {
          user {
            id
            email
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  end
end
