/* 
- Taken from:
  https://github.com/bhaikaju/node-api/blob/36317c3b5d306c29e04260e161a5516da24f13cc/middlewares/asyncMiddleware.js
  const handleAsyncError = fn => (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next)
  }
*/
const handleAsyncError = fn => {
  return (req, res, next) => {
    fn(req, res, next).catch(next)
  }
}

export default handleAsyncError