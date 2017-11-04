const TransferShipment = artifacts.require('./TransferShipment.sol')
const MintingShipment  = artifacts.require('./MintingShipment.sol')
const TokenInterface = artifacts.require('./TokenInterface.sol')
const SampleToken = artifacts.require('./SampleToken.sol')
const expectThrow = require('./helpers/expectThrow')

contract('Shipment Interface', accounts => {
  // instance of pricing contract
  let shipment
  let token
  let ownerSig = { from: accounts[0] }
  let index = 0

  beforeEach(async() => {
    token = await SampleToken.new(index++, ownerSig)
  })

  async function assertShipment(shipment, investor, amount, signature) {
    if (typeof signature === 'undefined') {
      signature = { from: accounts[0] }
    }

    assert(await shipment.ship(investor, amount, signature))
  }

  describe('Transfer shipment contract', async() => {
    beforeEach(async() => {
      shipment = await TransferShipment.new(accounts[0], token.address, ownerSig)
      await token.approve(shipment.address, web3.toWei(100, 'ether'), ownerSig)
    })

    it('could ship 10 tokens', async() => { assert(await shipment.canShip(accounts[1], web3.toWei(10, 'ether'))) })
    it('should ship 10 tokens', async() => { await assertShipment(shipment, accounts[1], web3.toWei(10, 'ether')) })
    it('shouldnt ship from non owner', async() => { expectThrow(shipment.ship(accounts[1], web3.toWei(10, 'ether'), { from: accounts[1] })) })

    it('should increase balance 10 tokens', async() => { 
      const amount = web3.toWei(10, 'ether')
      await shipment.ship(accounts[1], amount, ownerSig)
      const balance = await token.balanceOf(accounts[1])
      assert(balance.eq(amount), `balance isnt correct ${balance.toString(10)}`)
    })
  })

  describe('Minting shipment contract', async() => {
    beforeEach(async() => {
      shipment = await MintingShipment.new(token.address, ownerSig)
      await token.addRights(shipment.address)
    })

    it('could ship 10 tokens', async() => { assert(await shipment.canShip(accounts[1], web3.toWei(10, 'ether'))) })
    it('should ship 10 tokens', async() => { await assertShipment(shipment, accounts[1], web3.toWei(10, 'ether')) })
    it('shouldnt ship from non owner', async() => { expectThrow(shipment.ship(accounts[1], web3.toWei(10, 'ether'), { from: accounts[1] })) })


    it('should increase balance 10 tokens', async() => { 
      const amount = web3.toWei(10, 'ether')
      await shipment.ship(accounts[1], amount, ownerSig)
      const balance = await token.balanceOf(accounts[1])
      assert(balance.eq(amount), `balance isnt correct ${balance.toString(10)}`)
    })

    it('should return rights', async() => {
      let owner
      owner = await token.owner()
      assert(owner == shipment.address)

      await shipment.returnOwnership(ownerSig)

      owner = await token.owner()
      assert(owner == accounts[0])

    })
  })
})