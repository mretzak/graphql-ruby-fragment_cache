# frozen_string_literal: true

shared_context "check used key" do |options = {}|
  before do
    allow(schema.fragment_cache_store).to receive(:set)
  end

  it "uses expected key" do
    schema.execute(query, variables: variables || {}, context: context || {})

    expect(schema.fragment_cache_store).to \
      have_received(:set) do |used_key, _, passed_options|
        expect(used_key).to eq(key)
        expect(passed_options[:expires_in]).to eq(options[:expires_in]) if options[:expires_in]
      end
  end
end
