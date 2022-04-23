import express from 'express'
import morgan from 'morgan'

import rateLimit from 'express-rate-limit'
import helmet from 'helmet'
import mongoSanitize from 'express-mongo-sanitize'
import xss from 'xss-clean'
import hpp from 'hpp'

import AppError from './utils/AppError.js'
import globalErrorHandler from './utils/GlobalErrorHandler.js'
import productRoutes from './routes/productRoutes.js'
import userRoutes from './routes/userRoutes.js'

import path from 'path'
import { fileURLToPath } from 'url'

const app = express()

/* Global Middleware to set security HTTP Headers */
app.use(helmet())

/* Development environment logging */
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'))
}

/* Limit requests from same API */
const apiCallRateLimit = rateLimit({
  max: 100,
  windowMs: 60 * 60 * 1000,
  message: "Too many requests from this IP, please try again in an Hour!"
})
app.use('/api', apiCallRateLimit)

/* Body parser, reading data from body into req.body */
app.use(express.json({
  limit: '20kb'
}))

/* Sanitizing mongoose queries */
app.use(mongoSanitize())

/* Data sanitization against XSS */
app.use(xss())

/* Prevent Parameter Pollution */
app.use(hpp({
  whitelist: [
    'price'
  ]
}))

/* 
- To serve static content
- static folder is in parallel to src, so that code is separate from static content  
*/
const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)
// console.log(path.resolve(__dirname, '../'))
app.use('/public', express.static(`${path.resolve(__dirname, '../')}/static`))
// http://localhost:5000/public/assets/images/0.jpg

/* Adding req time to req object */
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString()
  next()
})

/* Routes */
app.use('/api/v1/products', productRoutes)
app.use('/api/v1/users', userRoutes)

/* Throw error if no routes found */
app.all('*', (req, res, next) => {
  next(new AppError(`The given endpoint ${req.originalUrl} is not found on ${req.protocol}://${req.headers.host}`, 404))
})

/* Global Error Handler */
app.use(globalErrorHandler)

export default app