import 'dotenv/config'
import app from './app.js'
import { connectMongo } from './config/db.js'

process.on('uncaughtException', err => {
  console.log('🥵 uncaughtException event fired!')
  console.log(err.name, err.message)
  console.log(err.stack)
  process.exit(1)
})

connectMongo()

const PORT = process.env.PORT || 3000
const server = app.listen(PORT, () => {
  console.log(`✔️ App running on port ${PORT} and in '${process.env.NODE_ENV}' environment.`)
})

process.on('unhandledRejection', (err) => {
  console.log('🥵 unhandledRejection event Fired, Shutting down the server.')
  console.log(err.name, err.message)
  console.log(err.stack)
  server.close(() => {
    process.exit(1)
  })
})