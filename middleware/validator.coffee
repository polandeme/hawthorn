valitator = {}

validator.prototype =
  loginName: (loginName) ->
    reg = /^(?!(([1][3|5|7|8][0-9]{9})|([\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+)))([0-9a-zA-Z_\u4E00-\u9FBF]+)/

module.exports = validator
