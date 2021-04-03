# frozen_string_literal: true

module GqlSupport
  def gql_query(query:, variables: {}, context: {}, account: nil)
    add_account(context: context, account: account)
    query = GraphQL::Query.new(
      LeitSchema,
      query,
      variables: variables.deep_stringify_keys,
      context: context
    )

    res = query.result
    puts "\nres: #{res.to_h}\n"
    res
  end

  private

  def add_account(context:, account:)
    return if account.blank?

    context[:current_account] = account
    context[:current_user] = account.users&.first
  end
end

RSpec.configure do |config|
  config.include GqlSupport, type: :gql
end
