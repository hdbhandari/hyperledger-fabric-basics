'use strict'

const { Contract } = require('fabric-contract-api')

class Student extends Contract {
  async initLedger(ctx) {
    const student = [
      { id: '101', name: "Ram", grade: 'A' },
      { id: '102', name: "Laxman", grade: 'A' },
    ]

    for (const stud of student) {
      await ctx.stub.putState(stud.id, Buffer.from(JSON.stringify(stud)))
    }
  }

  async createStudent(ctx, id, name, grade) {
    const asset = { id, name, grade }
    ctx.stub.putState(id, Buffer.from(JSON.stringify(asset)))
  }

  async getAllStudents(ctx) {
    const allResults = []
    // range query with empty string for startKey and endKey does an open-ended query of all assets in the chaincode namespace.
    const iterator = await ctx.stub.getStateByRange('', '')
    let result = await iterator.next()
    while (!result.done) {
      const strValue = Buffer.from(result.value.value.toString()).toString('utf8')
      let record
      try {
        record = JSON.parse(strValue)
      } catch (err) {
        console.log(err)
        record = strValue
      }
      allResults.push({ Key: result.value.key, Record: record })
      result = await iterator.next()
    }
    return JSON.stringify(allResults)
  }

  async getStudent(ctx, id) {
    const student = await ctx.stub.getState(id)
    if (!student || student.length === 0) {
      throw new Error(`The student ${id} does not exists.`)
    }
    return student.toString()
  }
}

module.exports = Student