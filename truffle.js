module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      gas: 50000000,
      gasPrice: 1,
      from: "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1",
      network_id: "*" // Match any network id
    }
  }
};
