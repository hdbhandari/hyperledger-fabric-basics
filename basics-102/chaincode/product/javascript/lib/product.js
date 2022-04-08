'use strict'

const { Contract } = require('fabric-contract-api')

class Product extends Contract {

    async initLedger(ctx) {
        console.info('============= START : Initialize Ledger with Products ===========')
        const products = [{
            "title": "Brown eggs",
            "type": "dairy",
            "description": "Raw organic brown eggs in a basket",
            "price": 28.1,
            "rating": 4
        }, {
            "title": "Sweet fresh stawberry",
            "type": "fruit",
            "description": "Sweet fresh stawberry on the wooden table",
            "price": 29.45,
            "rating": 4
        }, {
            "title": "Asparagus",
            "type": "vegetable",
            "description": "Asparagus with ham on the wooden table",
            "price": 18.95,
            "rating": 3
        }, {
            "title": "Green smoothie",
            "type": "dairy",
            "description": "Glass of green smoothie with quail egg's yolk, served with cocktail tube, green apple and baby spinach leaves over tin surface.",
            "price": 17.68,
            "rating": 4
        }, {
            "title": "Raw legums",
            "type": "vegetable",
            "description": "Raw legums on the wooden table",
            "price": 17.11,
            "rating": 2
        }, {
            "title": "Baking cake",
            "type": "dairy",
            "description": "Baking cake in rural kitchen - dough  recipe ingredients (eggs, flour, sugar) on vintage wooden table from above.",
            "price": 11.14,
            "rating": 4
        }]

        for (let i = 0; i < products.length; i++) {
            products[i].docType = 'product'
            await ctx.stub.putState('SKU-' + i, Buffer.from(JSON.stringify(products[i])))
            console.info('Added <--> ', products[i])
        }
        console.info('============= END : Initialize Ledger ===========')
    }

    async queryProduct(ctx, productSKU) {
        const productAsBytes = await ctx.stub.getState(productSKU) // get the product from chaincode state
        if (!productAsBytes || productAsBytes.length === 0) {
            throw new Error(`${productSKU} does not exist`)
        }
        console.log(productAsBytes.toString())
        return productAsBytes.toString()
    }

    async createProduct(ctx, productSKU, title, type, description, price, rating) {
        console.info('============= START : Create Product ===========')

        const product = {
            title,
            docType: 'product',
            type,
            description,
            price,
            rating
        }

        await ctx.stub.putState(productSKU, Buffer.from(JSON.stringify(product)))
        console.info('============= END : Create Car ===========')
    }

    async queryAllProducts(ctx) {
        const startKey = ''
        const endKey = ''
        const allResults = []
        for await (const { key, value } of ctx.stub.getStateByRange(startKey, endKey)) {
            const strValue = Buffer.from(value).toString('utf8')
            let record
            try {
                record = JSON.parse(strValue)
            } catch (err) {
                console.log(err)
                record = strValue
            }
            allResults.push({ Key: key, Record: record })
        }
        console.info(allResults)
        return JSON.stringify(allResults)
    }

    async changeProductName(ctx, productSKU, newName) {
        console.info('============= START : changeProductName ===========')

        const productAsBytes = await ctx.stub.getState(productSKU) // get the car from chaincode state
        if (!productAsBytes || productAsBytes.length === 0) {
            throw new Error(`${productSKU} does not exist`)
        }
        const product = JSON.parse(productAsBytes.toString())
        product.title = newOwner

        await ctx.stub.putState(productSKU, Buffer.from(JSON.stringify(product)))
        console.info('============= END : changeProductName ===========')
    }

}

module.exports = Product
