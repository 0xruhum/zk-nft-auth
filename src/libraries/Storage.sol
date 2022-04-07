pragma 0.8.10;


/*
  Library used to read specific storage slots from a contract.
  It's used by integrating this with the address type in the inheriting contract.
  Has to have following features:
  - we pass it a mapping and get the it's slot
  - we pass it the mapping and a key and it gets us the slot

  Do we really need all the tokenIDs to verify the ownership?
  If we pass the correct tokenID to the function it's not secure. Although the
  value is not stored in the blockchain, we query the data from someone. That person
  could record and leak all the requests. So that's not really a possibility.
  Do we need the tokenID at all?

  Don't we just need the following:
  - private signed & hashed msg proving ownership
  - private tokenID
  - public contract address
  - private actual owner -> here's the issue. Since this value is private we can't verify that it's actually the correct owner.
*/ 
library Storage {
  function getSlot() internal returns (uint) {

  }
}
