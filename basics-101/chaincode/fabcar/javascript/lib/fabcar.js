'use strict'

const { Contract } = require('fabric-contract-api')

class FabCar extends Contract {
    // Initializa ledger
    async initLedger(ctx) {
        ctx.stub.putState("test", "Hello World!")
    }

    // write key value pair of the Data
    async writeData(ctx, key, value) {
        ctx.stub.putState(key, value)
    }

    // Read data
    async readData(ctx, key) {
        const response = ctx.stub.getState(key)
        return response.toString()
    }
}

module.exports = FabCar
