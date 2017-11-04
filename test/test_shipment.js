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
    console.log('create token')
    token = await SampleToken.new(index++, ownerSig)
    console.log(await token.balanceOf(accounts[0]))
  })

  async function assertShipment(shipment, investor, amount, signature) {
    if (typeof signature === 'undefined') {
      signature = { from: accounts[0] }
    }

    assert(await shipment.ship(investor, amount, signature))
  }

  describe('transfer shipment', async() => {
    beforeEach(async() => {
      console.log('create shipment')
      shipment = await new TransferShipment(accounts[0], token.address, ownerSig)
      console.log(shipment.address)
      console.log(await shipment.canShip(accounts[1], web3.toWei(10, 'ether')))
      await token.approve(shipment.address, web3.toWei(100, 'ether'), ownerSig)
      console.log(await shipment.canShip(accounts[1], web3.toWei(10, 'ether')))
      // console.log(await token.allowance(accounts[0], shipment.address))
      let shipToken = await shipment.tokenAddress()
      console.log(shipToken)
      // console.log(TokenInterface.at(shipToken))
      // console.log(await shipToken.allowance(accounts[0], shipment.address))
    })

    it('should ship 10 tokens', async() => { await assertShipment(shipment, accounts[1], web3.toWei(10, 'ether')) })
    it('shouldnt ship from non owner', async() => { expectThrow(shipment.ship(accounts[1], web3.toWei(10, 'ether'), { from: accounts[1] })) })

    it('should increase balance 1000 tokens', async() => { 
      const amount = web3.toWei(1000, 'ether')
      await shipment.ship(accounts[1], amount, ownerSig)
      const balance = await token.balanceOf(accounts[1])
      assert(balance.eq(amount), `balance isnt correct ${balance.toString(10)}`)
    })
  })
})