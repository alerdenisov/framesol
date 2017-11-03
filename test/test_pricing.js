const StaticPricing = artifacts.require('./StaticPricing.sol')
const AmountPricing = artifacts.require('./AmountDependentPricing.sol')

contract('Pricing Interface', accounts => {
  // instance of pricing contract
  let pricing
  const decimals = 10

  async function assertChange(pricing, ethValue, tokenValue) {
    const changed = await pricing.change(accounts[0], web3.toWei(ethValue, 'ether'))
    assert(changed.eq(tokenValue * 10 ** decimals))
  }

  describe('static pricing', async() => {
    beforeEach(async() => {
      // 100 token per ether
      const priceWei = web3.toWei(0.01, 'ether')
      pricing = await StaticPricing.new(priceWei, decimals)
    })

    it('should allow to change 1 ETH', async() => { assert(await pricing.canChange(accounts[0], web3.toWei(1, 'ether'))) })
    it('should allow to change 10000 ETH', async() => { assert(await pricing.canChange(accounts[0], web3.toWei(10000, 'ether'))) })
    it('should allow to change 0.00001 ETH', async() => { assert(await pricing.canChange(accounts[0], web3.toWei(0.00001, 'ether'))) })

    it('should change 1 eth to 100 tokens', async() => { await assertChange(pricing, 1, 100) })
  })

  describe('dynamic pricing', async() => {
    beforeEach(async() => {
      // 100 token per ether
      pricing = await AmountPricing.new([
        0,
        web3.toWei(1, 'ether'),
        web3.toWei(10, 'ether'),
        // web3.toWei(100, 'ether'),
        // web3.toWei(1000, 'ether')
      ], [
        web3.toWei(0.01, 'ether'),
        web3.toWei(0.008, 'ether'),
        web3.toWei(0.006, 'ether'),
        // web3.toWei(0.002, 'ether'),
        // web3.toWei(0.001, 'ether'),
      ], decimals)
    })

    it('should allow to change 1 ETH', async() => { assert(await pricing.canChange(accounts[0], web3.toWei(1, 'ether'))) })
    it('should allow to change 10000 ETH', async() => { assert(await pricing.canChange(accounts[0], web3.toWei(10000, 'ether'))) })
    it('should allow to change 0.00001 ETH', async() => { assert(await pricing.canChange(accounts[0], web3.toWei(0.00001, 'ether'))) })

    it('should change .5 eth to 50 tokens', async() => { await assertChange(pricing, 0.5, 50) })
    it('should change  5 eth to 625 tokens', async() => { await assertChange(pricing, 5, 625) })
    it('should change 15 eth to 2500 tokens', async() => { await assertChange(pricing, 15, 2500) })
  })
})