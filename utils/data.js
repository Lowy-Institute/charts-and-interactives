const _ = require("lodash")
const fs = require("fs")
const yaml = require("js-yaml")
const glob = require("glob")
const moment = require("moment")
const root = "./app"

const useCache = process.env.NODE_ENV === "production"

let cache = {}

const getAll = function (type) {
  return (
    cache[type] ||
    glob
      .sync(root + "/**/" + type + "/*/*.yaml")
      .map(function (m) {
        return getOne(m.replace(root + "/", "").replace(".yaml", ""))
      })
      .sort(function (a, b) {
        var an, bn
        if (a.date || b.date) {
          return (
            moment(new Date(b.date)).toDate() -
            moment(new Date(a.date)).toDate()
          )
        } else if (a.path.match(/\d+/) || b.path.match(/\d+/)) {
          an = +a.path.match(/\d+/)[0]
          bn = +b.path.match(/\d+/)[0]
          return an - bn
        } else {
          return a.path.localeCompare(b.path)
        }
      })
      .filter(function (m) {
        return !m.hide
      })
  )
}

const getOne = function (type, name) {
  let result

  const path = _.compact([type, name]).join("/")
  const data = {
    path: path,
  }

  if (cache[type]) {
    result = cache[type]
  }

  return (
    result ||
    _.extend(
      data,
      (function () {
        var ref
        try {
          let file =
            (ref = glob.sync(root + "/" + path + "*.yaml")) != null
              ? ref[0]
              : void 0
          if (file == null) {
            file = "app/" + path + ".yaml"
          }

          const result = yaml.load(fs.readFileSync(file, "UTF-8"))

          if (useCache) {
            cache[type] = result
          }

          return result
        } catch (err) {
          console.error(err)
          return {}
        }
      })()
    )
  )
}

const getFolders = function (path) {
  return glob.sync(path + "/*/").map(function (m) {
    return m.replace(path, "").replace(/\//g, "")
  })
}

const clear = function () {
  return (cache = {})
}

module.exports = {
  getAll: getAll,
  getOne: getOne,
  getFolders: getFolders,
  clear: clear,
}
