class TestApiDescription
  def self.definition
    [
      {
        url: "/foos",
        actions: {
          create: {
            method: :post,
            request_contract: FooCreateRequestContract,
            response_contracts: {
              200 => FooCreateResponseContract,
            }
          }
        }
      }
    ]
  end
end
