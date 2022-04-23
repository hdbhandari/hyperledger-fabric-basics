/* This is global error handler middleware by express JS */
const globalErrorHandler = (err, req, res, next) => {
  err.statusCode = err?.statusCode || 500
  err.status = err?.status || 'error'
  console.log('Global Error handler: ', err.statusCode)
  console.log('Global Error handler: ', err.status)
  if (process.env.NODE_ENV === 'development') {
    devEnvError(err, res)
  } else if (process.env.NODE_ENV === 'production') {
    console.log("production")
    let updatedErr = { ...err }

    if (updatedErr.name === 'CastError') updatedErr = handleCastErrorDB(updatedErr)
    if (updatedErr.code === 11000) updatedErr = handleDuplicateFieldsDB(updatedErr)
    if (updatedErr.name === 'ValidationError') updatedErr = handleValidationErrorDB(updatedErr)
    if (updatedErr.name === 'JsonWebTokenError') updatedErr = handleJWTError()
    if (updatedErr.name === 'TokenExpiredError') updatedErr = handleJWTExpiredError()

    prodEnvError(updatedErr, res)
  } else {
    console.log('🟥 NODE_ENV not set properly, or not handled properly! 🟥')
  }

}

const devEnvError = (err, res) => {
  res
    .status(err.statusCode)
    .json({
      status: err.status,
      error: err,
      message: err.message,
      stack: err.stack
    })
}

const handleCastErrorDB = (err) => {
  const message = `Invalid ${err.path}: ${err.value}.`
  /* By throwing AppError, we will making it an operational Error */
  return new AppError(message, 400)
}

const handleDuplicateFieldsDB = err => {
  const value = err.errmsg.match(/(["'])(\\?.)*?\1/)[0]
  console.log('value: ', value)

  const message = `Duplicate field value: ${value}. Please use another value!`
  return new AppError(message, 400)
}

const handleValidationErrorDB = err => {
  const errors = Object.values(err.errors).map(el => el.message)

  const message = `Invalid input data. ${errors.join('. ')}`
  return new AppError(message, 400)
}

const prodEnvError = (err, res) => {
  // Operational, trusted error: send message to client
  if (err.isOperational) {
    res.status(err.statusCode).json({
      status: err.status,
      message: err.message
    })

    // Programming or other unknown error: don't leak error details
  } else {
    // 1) Log error
    console.error('ERROR 💥', err)

    // 2) Send generic message
    res.status(500).json({
      status: 'error',
      message: 'Something went very wrong!'
    })
  }
}

const handleJWTError = () =>
  new AppError('Invalid token. Please log in again!', 401)

const handleJWTExpiredError = () =>
  new AppError('Your token has expired! Please log in again.', 401)

export default globalErrorHandler