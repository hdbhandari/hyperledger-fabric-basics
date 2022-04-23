import handleAsyncError from '../utils/handleAsyncError.js'
import AppError from '../utils/AppError.js'

import { Gateway, Wallets } from 'fabric-network'
import path from 'path'
import fs from 'fs'
import { fileURLToPath } from 'url'
const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

export const createProduct = handleAsyncError(async (req, res, next) => {
  // const product = await Product.create(req.body)
  const product = {}
  res.status(201).json({
    status: 'success',
    data: {
      product
    }
  })
})

export const queryProduct = handleAsyncError(async (req, res, next) => {
  const products = {}
  res.status(200).json({
    status: 'success',
    results: products.length,
    data: {
      products
    }
  })
})

export const queryAllProducts = handleAsyncError(async (req, res, next) => {
  try {
    // load the network configuration
    const ccpPath = path.resolve(__dirname, '..', '..', '..', '..', 'test-network', 'organizations', 'peerOrganizations', 'org1.example.com', 'connection-org1.json')
    console.log("ccpPath: " + ccpPath)
    const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf8'))

    // Create a new file system based wallet for managing identities.
    const walletPath = path.join(process.cwd(), 'wallet')
    const wallet = await Wallets.newFileSystemWallet(walletPath)
    console.log(`Wallet path: ${walletPath}`)

    // Check to see if we've already enrolled the user.
    const identity = await wallet.get('appUser')
    if (!identity) {
      console.log('An identity for the user "appUser" does not exist in the wallet')
      console.log('Run the registerUser.js application before retrying')
      return
    }

    // Create a new gateway for connecting to our peer node.
    const gateway = new Gateway()
    await gateway.connect(ccp, { wallet, identity: 'appUser', discovery: { enabled: true, asLocalhost: true } })

    // Get the network (channel) our contract is deployed to.
    const network = await gateway.getNetwork('mychannel')

    // Get the contract from the network.
    const contract = network.getContract('product')

    // Evaluate the specified transaction.
    // queryProduct transaction - requires 1 argument, ex: ('queryProduct', 'SKU-2')
    // queryAllProducts transaction - requires no arguments, ex: ('queryAllProducts')
    const result = await contract.evaluateTransaction('queryAllProducts')
    console.log(`Transaction has been evaluated, result is: ${result.toString()}`)

    const singleProduct = await contract.evaluateTransaction('queryAllProducts')
    console.log(`Transaction has been evaluated, singleProduct is: ${singleProduct.toString()}`)
    const products = singleProduct.toString()

    // Disconnect from the gateway.
    await gateway.disconnect()

    res.status(200).json({
      status: 'success',
      data: {
        products: JSON.parse(products)
      }
    })
  } catch (error) {
    console.error(`Failed to evaluate transaction: ${error}`)
    throw new AppError(error.message, 500)
  }
})

export const changeProductName = handleAsyncError(async (req, res, next) => {
  const product = {}

  res.status(200).json({
    status: 'success',
    data: {
      product
    }
  })
})

/* export const deleteProduct = handleAsyncError(async (req, res, next) => {
  console.log("Delete product called")
  const product = await Product.findByIdAndDelete(req.params.id)
  console.log("Delete product called: ", product)
  if (!product) {
    return next(new AppError("No Product Exists to delete", 404))
  }

  res.status(204).json({
    status: 'success',
    data: null
  })
})

export const deleteAllProduct = handleAsyncError(async (req, res, next) => {
  console.log("Delete all")
  await Product.deleteMany()
  res.status(204).json({
    status: 'success',
    data: null
  })
}) */