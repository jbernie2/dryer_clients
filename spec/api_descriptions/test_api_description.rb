class TestApiDescription
  def self.definition
    [
      {
        url: "/foos",
        actions: {
          create: {
            method: :post,
            request_contract: Contracts::FooCreateRequestContract,
            response_contracts: {
              200 => Contracts::FooCreateResponseContract,
            }
          }
        }
      }
    ]
  end
end
