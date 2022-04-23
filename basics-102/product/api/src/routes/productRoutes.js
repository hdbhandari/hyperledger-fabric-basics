import express from 'express'
import {
  queryProduct,
  createProduct,
  queryAllProducts,
  changeProductName
} from '../controllers/ProductController.js'

const router = express.Router()

router.route('/createProduct').post(createProduct)
router.route('/queryProduct').get(queryProduct)
router.route('/queryAllProducts').get(queryAllProducts)
router.route('/changeProductName').patch(changeProductName)

export default router