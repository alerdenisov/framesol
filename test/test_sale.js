const SampleToken = artifacts.require('./SampleToken.sol')
const StaticPricing = artifacts.require('./StaticPricing.sol')
const TransferShipment = artifacts.require('./TransferShipment.sol')
const SaleForToken = artifacts.require('./SaleForToken.sol')

contract('Crowdsale', accounts => {
  // Sale contract (should implement SaleInterface)
  const ownerSig = { from: accounts[0] }
  let sale

  // describe('Static eth sale', async() => {
  //   beforeEach(async() => {
  //     sale = await StaticEtherSale.new()
  //   })
  // })

  describe('Static token sale', async() => {
    let mainToken, saleToken, price, pricing, shipment

    beforeEach(async() => {
      mainToken = await SampleToken.new(ownerSig)
      await mainToken.transfer(accounts[1], web3.toWei(50, 'ether'), ownerSig)

      saleToken = await SampleToken.new(ownerSig)

      // 10 sale tokens per 1 main token
      price = web3.toWei(0.1, 'ether')
      pricing = await StaticPricing.new(price, 18, ownerSig)

      // simple transfer shipment
      shipment = await TransferShipment.new(accounts[0], saleToken.address, ownerSig)
      await saleToken.approve(shipment.address, web3.toWei(10000, 'ether'), ownerSig)

      sale = await SaleForToken.new(mainToken.address, pricing.address, shipment.address, ownerSig);
      shipment.addRights(sale.address, ownerSig)
    })

    it('should sale for 10 main tokens', async() => {
      await mainToken.approveAndCall(sale.address, web3.toWei(10, 'ether'), 0, { from: accounts[1] });
    })

    it('should increate sale token balance', async() => {
      let balance
      balance = await saleToken.balanceOf(accounts[1])
      assert(balance.eq(0), `initial balance isn't 0 (${balance.div(10**18).toString(10)})`) 
      await mainToken.approveAndCall(sale.address, web3.toWei(5.34, 'ether'), 0, { from: accounts[1] });

      balance = await saleToken.balanceOf(accounts[1])
      assert(balance.eq(web3.toWei(53.4, 'ether')), `final balance isn't 53.4 tokens (${balance.div(10**18).toString(10)})`) 
    })
  })
})