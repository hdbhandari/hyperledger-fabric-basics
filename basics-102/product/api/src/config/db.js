import mongoose from 'mongoose'

export const connectMongo = () => mongoose.connect(process.env.DB_CONNECTION, {
  useNewUrlParser: true,
}).then(() => {
  console.log('✔️ DB Connected!')
})