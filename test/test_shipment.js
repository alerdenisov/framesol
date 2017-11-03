const TransferShipment = artifacts.require('./TransferShipment.sol')
const MintingShipment  = artifacts.require('./MintingShipment.sol')
const SampleToken = artifacts.require('./SampleToken.sol')
const expectThrow = require('./helpers/expectThrow')

contract('Shipment Interface', accounts => {
  // instance of pricing contract
  let shipment
  let token

  beforeEach(async() => {
    console.log('create token')
    token = await SampleToken.new();
  })

  async function assertShipment(shipment, investor, amount, signature) {
    if (typeof signature === 'undefined') {
      signature = { from: accounts[0] }
    }

    assert(await shipment.ship(investor, amount, signature))



    // let balance = await token.balanceOf(investor)
    // assert(balance.eq(amount))
  }

  describe('transfer shipment', async() => {
    beforeEach(async() => {
      console.log('create shipment')
      shipment = await new TransferShipment(accounts[0], token.address)
      await token.approve(shipment.address, await token.balanceOf(web3.toWei(5000, 'ether')))
    })

    it('should ship 1000 tokens', async() => { await assertShipment(shipment, accounts[1], web3.toWei(1000, 'ether')) })
    // it('shouldnt ship from non owner', async() => { expectThrow(shipment.ship(accounts[1], web3.toWei(1000, 'ether'), { from: accounts[1] })) })

    it('should increase balance 1000 tokens', async() => { 
      const amount = web3.toWei(1000, 'ether')
      await shipment.ship(accounts[1], amount, { from: accounts[0] })
      const balance = await token.balanceOf(accounts[1])
      assert(balance.eq(amount), `balance isnt correct ${balance.toString(10)}`)
    })
  })
})