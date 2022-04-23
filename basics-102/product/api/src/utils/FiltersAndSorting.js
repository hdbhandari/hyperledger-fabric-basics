class FiltersAndSorting {
  constructor(mongoQueryObj, reqQueryObj) {
    this.mongoQueryObj = mongoQueryObj
    this.reqQueryObj = reqQueryObj
  }

  filter() {
    const updatedReqQueryObj = { ...this.reqQueryObj }

    /* Removing all the fields which we will use as functionality */
    const exceptionsToSearchString = ['page', 'sort', 'limit', 'fields']
    exceptionsToSearchString.forEach(el => delete updatedReqQueryObj[el])
    console.log("In filter(): updatedReqQueryObj: ", this.updatedReqQueryObj)

    /* 
      Adding all operators, less than, greater than etc. 
      we need to pass them to mongoose with $lt, $gt etc.  
    */

    /* first parsing JSON to string, replacing 'lt' to '$lt' */
    let updatedReqQueryStr = JSON.stringify(updatedReqQueryObj)
    /* Prefixing $ to gte|gt|lte|lt */
    updatedReqQueryStr = updatedReqQueryStr.replace(/\b(gte|gt|lte|lt)\b/g, match => `$${match}`)

    /* 
      Because we are chaining through all the methods
      returning the whole classObject, so that all variables will pass along with 'this'
    */
    this.mongoQueryObj = this.mongoQueryObj.find(JSON.parse(updatedReqQueryStr))
    return this
  }

  sort() {
    console.log("In sort(): sort:", this.reqQueryObj.sort)
    if (this.reqQueryObj.sort) {
      /* 
        If there are multiple fields to be sorted, 
        then join them with space, and by removing ,
      */
      const sortBy = this.reqQueryObj.sort.split(',').join(' ')
      console.log(sortBy)
      this.mongoQueryObj = this.mongoQueryObj.sort(sortBy)
    } else {
      this.mongoQueryObj = this.mongoQueryObj.sort('-createdAt')
    }
    /* 
      Because we are chaining through all the methods
      returning the whole classObject, so that all variables will pass along with 'this'
    */
    return this
  }

  limitFields() {
    console.log("In limit() Fields: ", this.reqQueryObj.fields)
    if (this.reqQueryObj.fields) {
      const fields = this.reqQueryObj.fields.split(',').join(' ')
      this.mongoQueryObj = this.mongoQueryObj.select(fields)
    } else {
      this.mongoQueryObj = this.mongoQueryObj.select('-__v')
    }
    /* 
      Because we are chaining through all the methods
      returning the whole classObject, so that all variables will pass along with 'this'
    */
    return this
  }

  paginate() {
    console.log("In paginate() page: ", this.reqQueryObj.page)
    const page = this.reqQueryObj.page * 1 || 1
    const limit = this.reqQueryObj.limit * 1 || 100
    const skip = (page - 1) * limit

    this.mongoQueryObj = this.mongoQueryObj.skip(skip).limit(limit)
    /* 
      Because we are chaining through all the methods
      returning the whole classObject, so that all variables will pass along with 'this'
    */
    return this
  }
}

export default FiltersAndSorting